return {
    {
        "nvim-lualine/lualine.nvim",
        -- enabled = false,
        dependencies = {
            "gitsigns.nvim",
        },
        config = function ()
            require( "lualine" ).setup( {
                options = {
                    icons_enabled = false,
                    theme = "material",
                    component_separators = "",
                    section_separators = "",
                    disabled_filetypes = {
                        statusline = { "unite", "undotree", "help", "man" },
                        winbar = {},
                    },
                    ignore_focus = {},
                    always_divide_middle = true,
                    always_show_tabline = true,
                    globalstatus = false,
                    draw_empty = false,
                    refresh = {
                        statusline = 100,
                        tabline = 100,
                        winbar = 100,
                    }
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch", { "diff", colored = false }, "diagnostics" },
                    lualine_c = { { "filename", path = 4 } },
                    lualine_x = {},
                    lualine_y = { "filetype", { "encoding", show_bomb = true }, "fileformat-1" },
                    lualine_z = { "progress-1", "location-1" }
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = { "branch", { "diff", colored = false }, "diagnostics" },
                    lualine_c = { { "filename", path = 4 } },
                    lualine_x = {},
                    lualine_y = { "filetype", { "encoding", show_bomb = true }, "fileformat-1" },
                    lualine_z = { "progress-1", "location-1" }
                },
                tabline = {
                    lualine_a = {
                        {
                            "tabs",
                            mode = 1,
                            path = 1,
                            max_length = 100,
                            tab_max_length = 50,
                            use_mode_colors = true,
                        },
                    },
                    lualine_b = {},
                    lualine_c = {},
                    lualine_x = {},
                    lualine_y = {},
                    lualine_z = {}
                },
                winbar = {},
                inactive_winbar = {},
                extensions = {},
            } )
        end
    },
    {
        "vim-airline/vim-airline",
        enabled = false,
        dependencies = {
            "vim-airline/vim-airline-themes",
            "gitsigns.nvim",
        },
        init = function ()
            vim.g.airline_theme = "wombat"
            vim.g.airline_symbols_ascii = 1

            -- extensions
            vim.g[ "airline#extensions#whitespace#enabled" ] = 0
            vim.g[ "airline#extensions#branch#enabled" ] = 1
            vim.g[ "airline#extensions#xkblayout#enabled" ] = 1

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
