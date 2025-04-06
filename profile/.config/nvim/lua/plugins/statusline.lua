return {
    {
        "nvim-lualine/lualine.nvim",
        enabled = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function ()
            require( "lualine" ).setup( {
                options = {
                    icons_enabled = false,
                    theme = "auto",
                    component_separators = "", -- { left = "", right = "" },
                    section_separators = "", -- { left = "", right = "" },
                    disabled_filetypes = {
                        statusline = {},
                        winbar = {},
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    always_show_tabline = true,
                    globalstatus = false,
                    refresh = {
                        statusline = 100,
                        tabline = 100,
                        winbar = 100,
                    }
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", "diff", "diagnostics" },
                    lualine_c = { "filename" },
                    lualine_x = { "encoding", "fileformat", "filetype" },
                    lualine_y = { "progress" },
                    lualine_z = { "location" }
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { "filename" },
                    lualine_x = { "location" },
                    lualine_y = {},
                    lualine_z = {}
                },
                tabline = {},
                winbar = {},
                inactive_winbar = {},
                extensions = {},
            } )
        end
    },
    {
        "vim-airline/vim-airline",
        -- enabled = false,
        dependencies = {
            "vim-airline/vim-airline-themes",
            "gitsigns.nvim",
        },
        init = function ()
            vim.g.airline_theme = "wombat"
            vim.g.airline_symbols_ascii = 1

            -- extensions
            vim.g[ "airline#extensions#whitespace#enabled" ] = 0
            vim.g[ "airline#extensions#coc#enabled" ] = 0
            vim.g[ "airline#extensions#xkblayout#enabled" ] = 0

            -- tabline
            vim.g[ "airline#extensions#tabline#enabled" ] = 1
            vim.g[ "airline#extensions#tabline#show_buffers" ] = 0
            vim.g[ "airline#extensions#tabline#show_splits" ] = 0
            vim.g[ "airline#extensions#tabline#show_tabs" ] = 1
            vim.g[ "airline#extensions#tabline#show_tab_nr" ] = 0
            vim.g[ "airline#extensions#tabline#show_tab_type" ] = 0
            vim.g[ "airline#extensions#tabline#close_symbol" ] = "×"
            vim.g[ "airline#extensions#tabline#show_close_button" ] = 0
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
}
