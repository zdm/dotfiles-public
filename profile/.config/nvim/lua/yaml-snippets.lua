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

local custom_snippet_groups = {

    -- Snippets ONLY for standalone .js files
    javascript_pure = {
        {
            prefix = "snipa",
            body = "console.log('Snippet A - JS Only', ${1:value});$0",
            description = "Only displays in standalone JS files",
        },
    },

    -- Snippets shared between .js files and Vue script blocks
    javascript_shared = {
        {
            prefix = "snipb",
            body = "console.log('Snippet B - Shared', ${1:value});$0",
            description = "Displays in JS files and Vue script blocks",
        },
    },
}

local function active_snippet_groups ()
    local filetype = vim.bo.filetype

    if filetype == "javascript" then
        return { "javascript_pure", "javascript_shared" }
    end

    if filetype == "vue" then
        local injected_lang = get_ts_injection_lang()
        if injected_lang == "javascript" then
            return { "javascript_shared" }
        end
    end

    return {}
end

local M = {}
M.__index = M

function M.new ()
    return setmetatable( {}, M )
end

function M:enabled ()
    return vim.bo.filetype == "javascript" or vim.bo.filetype == "vue"
end

function M:get_trigger_characters ()
    return {}
end

local INSERT_TEXT_FORMAT_SNIPPET = 2

function M:get_completions ( ctx, callback )
    local kinds = require( "blink.cmp.types" ).CompletionItemKind

    local items = {}

    for _, group_name in ipairs( active_snippet_groups() ) do
        for _, snip in ipairs( custom_snippet_groups[ group_name ] or {} ) do
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
