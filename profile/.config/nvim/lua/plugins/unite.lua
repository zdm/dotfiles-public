return {
    {
        "shougo/unite.vim",
        init = function ()
            vim.g.unite_data_directory = vim.fn.stdpath( "data" ) .. "/unite"
            vim.g.unite_source_bookmark_directory = vim.fn.stdpath( "config" ) .. "/unite/bookmark"
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

            vim.keymap.set( { "n", "i", "v" }, "<F3>", function ()
                local os

                if vim.fn.has( "win64" ) == 1 or vim.fn.has( "win32" ) == 1 then
                    os = "windows"
                else
                    os = "linux"
                end

                vim.cmd( "Unite -buffer-name=MRU -toggle -prompt-direction=top -start-insert -no-restore bookmark:default-" .. os .. " neomru/file" )
            end, { noremap = true, silent = true } )

            vim.keymap.set( { "n", "i", "v" }, "<F4>", function ()
                vim.cmd( "Unite -buffer-name=buffers -toggle -prompt-direction=top -start-insert -no-restore buffer" )
            end, { noremap = true, silent = true } )
        end
    },
    {
        "shougo/neomru.vim",
        dependencies = {
            "unite.vim"
        },

        -- TODO: rename to init, https://github.com/folke/lazy.nvim/issues/1958
        config = function ()
            vim.g[ "neomru#file_mru_path"] = vim.g.unite_data_directory .. "/neomru/file"
            vim.g[ "neomru#directory_mru_path"] = vim.g.unite_data_directory .. "/neomru/directory"
        end
    },
}
