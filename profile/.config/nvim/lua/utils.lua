local M = {}
local ignored_filetypes

M.ignored_filetypes = {
    "DiffviewFileHistory",
    "DiffviewFiles",
    "gitgraph",
    "help",
    "man",
    "TelescopePrompt",
}

M.is_filetype_ignored = function ( filetype )
    if ignored_filetypes == nil then
        ignored_filetypes = {}

        for _, value in pairs( M.ignored_filetypes ) do
            ignored_filetypes[ value ] = true
        end
    end

    return ignored_filetypes[ filetype ]
end

M.has_treesitter = function ( bufnr )
    if not bufnr then
        bufnr = vim.api.nvim_get_current_buf()
    end

    local highlighter = require( "vim.treesitter.highlighter" )

    if highlighter.active[ bufnr ] then
        return true
    else
        return false
    end
end

M.parse_treesitter = function ( bufnr, callback )
    local parser = vim.treesitter.get_parser( bufnr )

    if not parser then return end

    -- XXX https://neovim.io/doc/user/treesitter.html#LanguageTree%3Aparse()
    parser:parse( true, callback )
end

M.update_folds = function ( bufnr, recalculate_only )
    if M.has_treesitter( bufnr ) then
        M.parse_treesitter( bufnr, function ()
            if recalculate_only then

                -- recompile folds
                vim.o.foldmethod = vim.o.foldmethod

                vim.cmd.normal( "zv" )
            else
                vim.cmd.normal( "zx" )
            end
        end )
    else
        if recalculate_only then

            -- recompile folds
            vim.o.foldmethod = vim.o.foldmethod

            vim.cmd.normal( "zv" )
        else
            vim.cmd.normal( "zx" )
        end
    end
end

return M
