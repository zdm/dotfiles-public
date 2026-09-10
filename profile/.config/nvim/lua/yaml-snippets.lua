local ts_lang_cache = {}

local function get_ts_injection_lang ()
    local buf = vim.api.nvim_get_current_buf()
    local row, col = unpack( vim.api.nvim_win_get_cursor( 0 ) )

    row = row - 1

    local changedtick = vim.api.nvim_buf_get_changedtick( buf )

    if ts_lang_cache.buf == buf
        and ts_lang_cache.changedtick == changedtick
        and ts_lang_cache.row == row
        and ts_lang_cache.col == col
    then
        return ts_lang_cache.lang
    end

    local ok, parser = pcall( vim.treesitter.get_parser, buf )
    local lang = nil

    if ok and parser then
        local lang_tree = parser:language_for_range( { row, col, row, col } )
        if lang_tree then lang = lang_tree:lang() end
    end

    ts_lang_cache = { buf = buf, changedtick = changedtick, row = row, col = col, lang = lang }

    return lang
end

-- Maps vim `filetype` to its treesitter language name, only where the two
-- differ (e.g. filetype "vimscript" -> lang "vim"). Anything not listed
-- here is assumed to share its name between filetype and lang.
local filetype_to_lang = {}

local function get_base_lang ()
    local filetype = vim.bo.filetype
    return filetype_to_lang[ filetype ] or filetype
end

-- Every language a buffer could resolve to right now: its own base
-- language, plus whatever treesitter says is injected at the cursor
-- (if the buffer embeds other languages, e.g. Vue/Markdown/HTML).
local function active_langs ()
    local langs = { [ get_base_lang() ] = true }

    local injected_lang = get_ts_injection_lang()
    if injected_lang then
        langs[ injected_lang ] = true
    end

    return langs
end

-- Returns the raw snippet-group data. Static for now, but kept as its own
-- function (called once from M.new()) so it can later be swapped for
-- something that reads snippets from disk, a plugin option, etc. without
-- touching anything else in this module.
local function load_snippets ()
    return {

        -- Snippets ONLY for standalone .js files
        javascript_pure = {
            langs = { "javascript" },
            snippets = {
                {
                    prefix = "snipa",
                    body = "console.log('Snippet A - JS Only', ${1:value});$0",
                    description = "Only displays in standalone JS files",
                },
            },
        },

        -- Snippets shared between .js files and any embedded/injected JS
        -- (Vue <script>, Markdown code fences, HTML <script>, etc.)
        javascript_shared = {
            langs = { "javascript" },
            snippets = {
                {
                    prefix = "snipb",
                    body = "console.log('Snippet B - Shared', ${1:value});$0",
                    description = "Displays in JS files and JS injections",
                },
            },
        },

        -- Example of a second language group, to show the pattern generalizes
        -- beyond javascript/vue.
        lua_pure = {
            langs = { "lua" },
            snippets = {
                {
                    prefix = "snipc",
                    body = "vim.notify( \"${1:message}\" )$0",
                    description = "Only displays in Lua files/injections",
                },
            },
        },
    }
end

-- Filetypes this source should run for at all — either because there are
-- snippets targeting that language directly, or because that filetype can
-- embed other languages we have snippets for (e.g. vue/markdown/html can
-- inject javascript). Add a filetype here whenever a new host language
-- needs to reach the shared groups via injection.
local host_filetypes = {
    javascript = true,
    typescript = true,
    lua = true,
    vue = true,
    markdown = true,
    html = true,
}

local function active_snippet_groups ( snippet_groups )
    local langs = active_langs()
    local groups = {}

    for _, group in pairs( snippet_groups ) do
        for _, lang in ipairs( group.langs ) do
            if langs[ lang ] then
                table.insert( groups, group )
                break
            end
        end
    end

    return groups
end

local M = {}
M.__index = M

function M.new ()
    return setmetatable( { snippet_groups = load_snippets() }, M )
end

function M:enabled ()
    return host_filetypes[ vim.bo.filetype ] == true
end

function M:get_trigger_characters ()
    return {}
end

local INSERT_TEXT_FORMAT_SNIPPET = 2

function M:get_completions ( ctx, callback )
    local kinds = require( "blink.cmp.types" ).CompletionItemKind

    local items = {}

    for _, group in ipairs( active_snippet_groups( self.snippet_groups ) ) do
        for _, snip in ipairs( group.snippets ) do
            table.insert( items, {
                label = snip.prefix,
                kind = kinds.Snippet,
                insertText = snip.body,
                insertTextFormat = INSERT_TEXT_FORMAT_SNIPPET,
                documentation = {
                    kind = "markdown",
                    value = snip.description,
                },
            } )
        end
    end

    callback( {
        context = ctx,
        is_incomplete_forward = false,
        is_incomplete_backward = false,
        items = items,
    } )

    -- no async work in flight, nothing to cancel
    return function () end
end

return M
