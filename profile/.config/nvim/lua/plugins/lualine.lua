local diff_signs = {
    added    = "+",
    modified = "~",
    removed  = "-",
}

return {
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {
            "gitsigns.nvim",
        },
        config = function ()
            require( "lualine" ).setup( {
                options = {
                    icons_enabled = true,
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
                    lualine_b = { { "branch", icon = "⎇" }, { "diff", colored = false, symbols = diff_signs }, "diagnostics" },
                    lualine_c = { { "filename", path = 4 } },
                    lualine_x = {},
                    lualine_y = { "filetype", { "encoding", show_bomb = true }, "new.fileformat" },
                    lualine_z = { "new.progress", "new.location" }
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = { { "branch", icon = "⎇" }, { "diff", colored = false, symbols = diff_signs }, "diagnostics" },
                    lualine_c = { { "filename", path = 4 } },
                    lualine_x = {},
                    lualine_y = { "filetype", { "encoding", show_bomb = true }, "new.fileformat" },
                    lualine_z = { "new.progress", "new.location" }
                },
                tabline = {
                    lualine_a = {
                        {
                            "tabs",
                            mode = 1,
                            path = 0,
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
}
