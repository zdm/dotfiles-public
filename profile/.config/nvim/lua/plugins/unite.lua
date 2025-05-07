return {
    {
        "shougo/unite.vim",
        init = function ()
            vim.g.unite_force_overwrite_statusline = 0
            vim.g.unite_cursor_line_highlight = "CursorLine"
            vim.g.unite_source_menu_menus = vim.empty_dict()
            vim.g.unite_winheight = 20
            vim.g.unite_winwidth = 40
            vim.g.unite_split_rule = "botright"
        end,
        config = function ()
            vim.api.nvim_create_autocmd( "FileType", {
                pattern = "unite",
                callback = function ()
                    vim.keymap.set( "n", "<ESC>", "<Plug>(unite_exit)", { remap = true, buffer = true, silent = true } )

                    vim.keymap.set( { "n", "i" }, "<C-t>", "unite#do_action( 'tabopen' )", { noremap = true, buffer = true, silent = true, expr = true } )

                    vim.keymap.set( { "n", "i" }, "<C-s>", "unite#do_action( 'split' )", { noremap = true, buffer = true, silent = true, expr = true } )

                    vim.keymap.set( { "n", "i" }, "<C-v>", "unite#do_action( 'vsplit' )", { noremap = true, buffer = true, silent = true, expr = true } )

                    vim.keymap.set( { "n", "i" }, "<C-d>", "unite#do_action( 'delete' )", { noremap = true, buffer = true, silent = true, expr = true } )

                    vim.keymap.set( { "n", "i" }, "<C-CR>", "unite#do_action( 'tabswitch' )", { noremap = true, buffer = true, silent = true, expr = true } )
                end
            } )
        end
    },
}
