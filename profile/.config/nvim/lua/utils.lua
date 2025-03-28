local M = {}

M.hasTreesitter = function ( bufnr )
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

M.parseTreesitter = function ( bufnr, range )
    local parser = vim.treesitter.get_parser( bufnr )

    -- XXX https://neovim.io/doc/user/treesitter.html#LanguageTree%3Aparse()
    parser:parse( range )
end

return M
