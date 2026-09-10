local INSERT_TEXT_FORMAT_SNIPPET = 2
local is_treesitter_available = pcall( require, "nvim-treesitter.util" )
local supported_filetypes

-- XXX add cache?
local function get_language_at_cursor ( bufnr )
    if not bufnr then
        bufnr = vim.api.nvim_get_current_buf()
    end

    local languages = {
        language = "",
        injected_language = "",
    }

    if is_treesitter_available then
        local cur_node = vim.treesitter.get_node( { bufnr = bufnr } )

        -- file parsed with treesitter
        if cur_node then
            local parser = vim.treesitter.get_parser( bufnr )
            local language_tree_at_cursor = parser:language_for_range( { cur_node:range() } )
            local language_at_cursor = language_tree_at_cursor:lang()

            -- has language at cursor
            if language_at_cursor then
                languages.language = language_at_cursor

                local parent_language_tree = language_tree_at_cursor:parent()

                -- has parent language
                if parent_language_tree then
                    local parent_language = parent_language_tree:lang()

                    if parent_language then
                        languages.injected_language = parent_language .. "/" .. language_at_cursor
                    end
                end

                return languages
            end
        end
    end

    -- file not parsed with treesitter
    languages.language = vim.bo[ bufnr ].filetype or ""

    return languages
end

local function load_snippets ( snippets_path )
    local data = {
        javascript = {
            snippets = {
                snip_a = {
                    prefix = "snip_a",
                    body = "console.log('Snippet A - JS Only', ${1:value});$0",
                    description = "Only displays in standalone JS files",
                }
            },
        },
        [ "html/javascript" ] = {
            inherit = {
                "javascript",
            },
            snippets = {
                snip_b = {
                    prefix = "snip_b",
                    body = "console.log('Snippet A - JS Only', ${1:value});$0",
                    description = "Only displays in standalone JS files",
                }
            },
        },
        [ "vue/javascript" ] = {
            inherit = {
                "javascript",
                "html/javascript",
            },
            snippets = {
                snip_c = {
                    prefix = "snip_c",
                    body = "console.log('Snippet A - JS Only', ${1:value});$0",
                    description = "Only displays in standalone JS files",
                }
            },
        },
    }

    local kinds = require( "blink.cmp.types" ).CompletionItemKind
    local snippets = {}

    supported_filetypes = {}

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

            if type( snippet_data.prefix ) == "string" then
                table.insert( result[ language ], {
                    label = snippet_data.prefix,
                    kind = kinds.Snippet,
                    insertText = snippet_data.body,
                    insertTextFormat = INSERT_TEXT_FORMAT_SNIPPET,
                    documentation = {
                        kind = "markdown",
                        value = snippet_data.description,
                    },
                } )
            else
                for index, prefix in ipairs( snippet_data.prefix ) do
                    table.insert( result[ language ], {
                        label = prefix,
                        kind = kinds.Snippet,
                        insertText = snippet_data.body,
                        insertTextFormat = INSERT_TEXT_FORMAT_SNIPPET,
                        documentation = {
                            kind = "markdown",
                            value = snippet_data.description,
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

-- XXX get lang at cursor
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
