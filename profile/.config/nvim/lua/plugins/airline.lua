return {
    {
        "vim-airline/vim-airline",
        init = function ()
            vim.g.airline_theme = "wombat"
            vim.g.airline_symbols_ascii = 1

            -- extensions
            vim.g[ "airline#extensions#whitespace#enabled" ] = 0
            vim.g[ "airline#extensions#coc#enabled" ] = 0

            vim.g[ "airline#extensions#tabline#enabled" ] = 1
            vim.g[ "airline#extensions#tabline#show_buffers" ] = 0
            vim.g[ "airline#extensions#tabline#show_splits" ] = 0
            vim.g[ "airline#extensions#tabline#show_tabs" ] = 1
            vim.g[ "airline#extensions#tabline#show_tab_nr" ] = 0
            vim.g[ "airline#extensions#tabline#show_tab_type" ] = 0
            vim.g[ "airline#extensions#tabline#close_symbol" ] = "×"
            vim.g[ "airline#extensions#tabline#show_close_button" ] = 0
            vim.g[ "airline#extensions#xkblayout#enabled" ] = 0

            vim.g[ "airline#extensions#tabline#formatter" ] = "short_path"
            -- vim.g[ "airline#extensions#tabline#fnamecollapse" ] = 0
            -- vim.g[ "airline#extensions#tabline#fnamemod" ] = ":t"

            -- customize airline sections
            -- function! AirlineInit()
            --    let g:airline_section_x = airline#section#create_left( [ "session" ] )
            -- endf
            -- autocmd VimEnter * call AirlineInit()
        end
    },
    { "vim-airline/vim-airline-themes" },
}
