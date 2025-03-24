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
                -- autocmd FileType unite call s:uniteCustomization()

                -- function! s:uniteCustomization ()
                --     nmap <silent><buffer> <ESC> <Plug>(unite_exit)

                --     nnoremap <silent><buffer><expr> <C-t> unite#do_action('tabopen')
                --     inoremap <silent><buffer><expr> <C-t> unite#do_action('tabopen')

                --     nnoremap <silent><buffer><expr> <C-s> unite#do_action('split')
                --     inoremap <silent><buffer><expr> <C-s> unite#do_action('split')

                --     nnoremap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
                --     inoremap <silent><buffer><expr> <C-v> unite#do_action('vsplit')

                --     nnoremap <silent><buffer><expr> <C-d> unite#do_action('delete')
                --     inoremap <silent><buffer><expr> <C-d> unite#do_action('delete')

                --     nnoremap <silent><buffer><expr> <C-CR> unite#do_action('tabswitch')
                --     inoremap <silent><buffer><expr> <C-CR> unite#do_action('tabswitch')
                -- endfunction

                -- nnoremap <silent> <F4> :Unite -buffer-name=buffers -toggle -prompt-direction=top -start-insert -no-restore buffer<CR>
                -- inoremap <silent> <F4> <C-o>:Unite -buffer-name=buffers -toggle -prompt-direction=top -start-insert -no-restore buffer<CR>
                -- vnoremap <silent> <F4> <ESC>:Unite -buffer-name=buffers -toggle -prompt-direction=top -start-insert -no-restore buffer<CR>

                -- if has('win16') || has('win32') || has('win64')
                --     nnoremap <silent> <F3> :Unite -buffer-name=MRU -toggle -prompt-direction=top -start-insert -no-restore bookmark:default-windows neomru/file<CR>
                --     inoremap <silent> <F3> <C-o>:Unite -buffer-name=MRU -toggle -prompt-direction=top -start-insert -no-restore bookmark:default-windows neomru/file<CR>
                --     vnoremap <silent> <F3> <ESC>:Unite -buffer-name=MRU -toggle -prompt-direction=top -start-insert -no-restore bookmark:default-windows neomru/file<CR>
                -- else
                --     nnoremap <silent> <F3> :Unite -buffer-name=MRU -toggle -prompt-direction=top -start-insert -no-restore bookmark:default-linux neomru/file<CR>
                --     inoremap <silent> <F3> <C-o>:Unite -buffer-name=MRU -toggle -prompt-direction=top -start-insert -no-restore bookmark:default-linux neomru/file<CR>
                --     vnoremap <silent> <F3> <ESC>:Unite -buffer-name=MRU -toggle -prompt-direction=top -start-insert -no-restore bookmark:default-linux neomru/file<CR>
                -- endif

            end
    },
    {
        "shougo/neomru.vim",
        dependencies = {
            "shougo/unite.vim"
        },
        init = function ()
            vim.g[ "neomru#file_mru_path"] = vim.g.unite_data_directory .. "/neomru/file"
            vim.g[ "neomru#directory_mru_path"] = vim.g.unite_data_directory .. "/neomru/directory"
        end
    },
    {
        "shougo/unite-outline",
        dependencies = {
            "shougo/unite.vim"
        },
        config = function ()
            vim.keymap.set( { "n", "i", "v" }, "<F8>", function ()
                vim.cmd( "Unite -buffer-name=outline -toggle -vertical -direction=botright -winwidth=60 -start-insert -no-restore outline" )
            end, { noremap = true, silent = true } )
        end
    },
}
