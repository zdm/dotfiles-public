local INSERT_TEXT_FORMAT_SNIPPET = 2
local is_treesitter_available = pcall( require, "nvim-treesitter.util" )
local supported_filetypes
local language_at_cursor_cache_by_buf = {}

vim.api.nvim_create_autocmd( "BufWipeout", {
    callback = function ( args )
        language_at_cursor_cache_by_buf[ args.buf ] = nil
    end,
} )

local function find_language_tree_at_point ( language_tree, row, col )
    for _, tree in ipairs( language_tree:trees() ) do
        local srow, scol, erow, ecol = tree:root():range()

        local after_start = ( row > srow ) or ( row == srow and col >= scol )
        local before_end = ( row < erow ) or ( row == erow and col <= ecol )

        if after_start and before_end then
            return language_tree
        end
    end

    for _, child_tree in pairs( language_tree:children() ) do
        local found = find_language_tree_at_point( child_tree, row, col )

        if found then
            return found
        end
    end

    return nil
end

local function get_fenced_code_block_lang ( node, bufnr )
    for child in node:iter_children() do
        if child:type() == "info_string" then
            local text = vim.treesitter.get_node_text( child, bufnr )

            return vim.treesitter.language.get_lang( text ) or text
        end
    end

    return nil
end

local function resolve_language_tree ( parser, bufnr, row, col )
    -- ignore_injections defaults to true, which would keep cur_node inside
    -- whatever tree "parser" itself belongs to (e.g. markdown) and never
    -- let its ancestors cross into an injected tree (e.g. javascript) at
    -- all - the walk below needs an actual node from the deepest tree that
    -- structurally exists, so injections must not be ignored here
    local cur_node = vim.treesitter.get_node( { bufnr = bufnr, pos = { row, col }, ignore_injections = false } )

    -- the language tree that cur_node's range structurally belongs to
    -- (e.g. "javascript" for a fenced code block inside markdown, or just
    -- "parser" itself if there's no injection at this point at all). Used
    -- both as the fast-path result and as the reported parent below, since
    -- that is the correct *immediate* parent - not the outer "parser" arg,
    -- which may be several injection levels further up (e.g. "markdown").
    local immediate_tree = parser

    if cur_node then
        immediate_tree = parser:language_for_range( { cur_node:range() } ) or parser
    end

    -- walk up from the node first, before trusting immediate_tree - if the
    -- cursor sits inside a tagged template literal or a fenced code block,
    -- that ancestor is the most specific language available. An
    -- empty/whitespace-only tagged template has no string_fragment node for
    -- the injection query to match, so no child tree is ever created for
    -- it; immediate_tree would then stop one injection level too shallow
    -- (e.g. resolving to "javascript" instead of "sql" inside `` sql`` ``,
    -- because that's as deep as the injection metadata goes). Checking this
    -- first means a real, already-parsed injection (which resolves to the
    -- same language via its tag anyway) never has to reach the fast path
    -- below, and an absent one still gets the right answer.
    local node = cur_node

    while node do
        if node:type() == "fenced_code_block" then
            local resolved_lang = get_fenced_code_block_lang( node, bufnr )

            if resolved_lang then
                return {
                    lang = function () return resolved_lang end,
                    parent = function () return immediate_tree end,
                }
            end

        elseif node:type() == "template_string" then
            local call_node = node:parent()

            if call_node and call_node:type() == "call_expression" then
                local tag_node = call_node:field( "function" )[ 1 ]

                if tag_node and tag_node:type() == "identifier" then
                    local text = vim.treesitter.get_node_text( tag_node, bufnr )
                    local resolved_lang = vim.treesitter.language.get_lang( text ) or text

                    return {
                        lang = function () return resolved_lang end,
                        parent = function () return immediate_tree end,
                    }
                end
            end
        end

        node = node:parent()
    end

    -- fast path: immediate_tree already resolves correctly
    if immediate_tree ~= parser then
        return immediate_tree
    end

    -- immediate_tree resolution failed entirely - the point falls in a
    -- region a child tree's own parsed nodes don't reach (e.g. a blank
    -- leading/trailing line inside a fenced code block), even though the
    -- block structurally still contains it. cur_node above may already
    -- belong to that child tree, and node:parent() can never walk back out
    -- of it to reach an enclosing fenced_code_block in the host tree.
    -- Re-fetching the node with injections ignored guarantees a node that
    -- lives in the host tree, so the same check can still find it here.
    local host_node = vim.treesitter.get_node( { bufnr = bufnr, pos = { row, col }, ignore_injections = true } )

    node = host_node

    while node do
        if node:type() == "fenced_code_block" then
            local resolved_lang = get_fenced_code_block_lang( node, bufnr )

            if resolved_lang then
                return {
                    lang = function () return resolved_lang end,
                    parent = function () return immediate_tree end,
                }
            end
        end

        node = node:parent()
    end

    -- root tree was returned - walk injected children directly and check
    -- if the point falls inside one of them, instead of trusting cur_node's
    -- possibly too-wide range
    local found_tree = nil

    for _, child_tree in pairs( parser:children() ) do
        found_tree = find_language_tree_at_point( child_tree, row, col )

        if found_tree then
            break;
        end
    end

    if found_tree then
        return found_tree
    end

    return parser
end

local function get_language_at_cursor ( bufnr )
    if not bufnr then
        bufnr = vim.api.nvim_get_current_buf()
    end

    local row, col = unpack( vim.api.nvim_win_get_cursor( 0 ) )

    row = row - 1

    local changedtick = vim.api.nvim_buf_get_changedtick( bufnr )

    local cached = language_at_cursor_cache_by_buf[ bufnr ]

    if cached
        and cached.changedtick == changedtick
        and cached.row == row
        and cached.col == col
    then
        return cached.languages
    end

    local languages = {
        language = nil,
        injected_language = nil,
    }

    local resolved_from_treesitter = false

    if is_treesitter_available then
        local ok, parser = pcall( vim.treesitter.get_parser, bufnr )

        -- file parsed with treesitter
        if ok and parser then
            local language_tree_at_cursor = resolve_language_tree( parser, bufnr, row, col )
            local language_at_cursor = language_tree_at_cursor:lang()

            -- has language at cursor
            if language_at_cursor then
                languages.language = language_at_cursor
                resolved_from_treesitter = true

                local parent_language_tree = language_tree_at_cursor:parent()

                -- has parent language
                if parent_language_tree then
                    local parent_language = parent_language_tree:lang()

                    if parent_language then
                        languages.injected_language = parent_language .. "/" .. language_at_cursor
                    end
                end
            end
        end
    end

    -- file not parsed with treesitter (or no language resolved at cursor)
    if not resolved_from_treesitter then
        local filetype = vim.bo[ bufnr ].filetype

        if filetype ~= "" then
            languages.language = filetype
        end
    end

    language_at_cursor_cache_by_buf[ bufnr ] = {
        changedtick = changedtick,
        row = row,
        col = col,
        languages = languages,
    }

    return languages
end

local function load_snippets ( snippets_path )
    local yaml = require( "tinyyaml" )

    supported_filetypes = {}

    local file = io.open( snippets_path, "r" )
    if not file then return {} end

    local content = file:read( "*all" )
    file:close()

    local success, data = pcall( yaml.parse, content )
    if not success or type( data ) ~= "table" then
        -- vim.notify( "Failed to parse YAML snippet file: " .. path, vim.log.levels.ERROR )
        return {}
    end

    local kinds = require( "blink.cmp.types" ).CompletionItemKind
    local snippets = {}

    for language, language_data in pairs( data ) do
        local slash_pos = string.find( language, "/" )

        if slash_pos then
            supported_filetypes[ string.sub( language, 1, slash_pos - 1 ) ] = true
        else
            supported_filetypes[ language ] = true
        end

        if language_data.inherit then
            for index, inherit_language in ipairs( language_data.inherit ) do
                if data[ inherit_language ] and data[ inherit_language ].snippets then
                    for snippet_name, snippet_data in pairs( data[ inherit_language ].snippets ) do
                        snippets[ language ] = snippets[ language ] or {}

                        snippets[ language ][ snippet_name ] = snippet_data
                    end
                end
            end
        end

        if language_data.snippets then
            for snippet_name, snippet_data in pairs( language_data.snippets ) do
                snippets[ language ] = snippets[ language ] or {}

                snippets[ language ][ snippet_name ] = snippet_data
            end
        end
    end

    local result = {}

    for language, language_data in pairs( snippets ) do
        for snippet_name, snippet_data in pairs( language_data ) do
            result[ language ] = result[ language ] or {}

            if type( snippet_data.trigger ) == "string" then
                table.insert( result[ language ], {
                    label = snippet_data.trigger,
                    kind = kinds.Snippet,
                    insertText = snippet_data.body,
                    insertTextFormat = INSERT_TEXT_FORMAT_SNIPPET,
                    documentation = {
                        kind = "markdown",
                        value = snippet_data.description or snippet_data.body,
                    },
                } )
            else
                for index, trigger in ipairs( snippet_data.trigger ) do
                    table.insert( result[ language ], {
                        label = trigger,
                        kind = kinds.Snippet,
                        insertText = snippet_data.body,
                        insertTextFormat = INSERT_TEXT_FORMAT_SNIPPET,
                        documentation = {
                            kind = "markdown",
                            value = snippet_data.description or snippet_data.body,
                        },
                    } )
                end
            end
        end
    end

    return result
end

local M = {}

M.__index = M

function M.new ()
    local snippets_path = vim.fn.stdpath( "config" ) .. "/snippets.yaml"

    return setmetatable( {
        snippets_path = snippets_path,
        snippets = load_snippets( snippets_path ),
    }, M )
end

function M:enabled ()
    return supported_filetypes[ vim.bo.filetype ] == true
end

function M:get_trigger_characters ()
    return {}
end

function M:get_completions ( ctx, callback )
    local languages = get_language_at_cursor()
    local items

    if languages.injected_language and self.snippets[ languages.injected_language ] then
        items = self.snippets[ languages.injected_language ]
    elseif languages.language and self.snippets[ languages.language ] then
        items = self.snippets[ languages.language ]
    else
        items = {}
    end

    callback( {
        context = ctx,
        is_incomplete_forward = false,
        is_incomplete_backward = false,
        items = items,
    } )

    return function () end
end

return M
