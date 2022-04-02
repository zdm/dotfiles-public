local diff_signs = {
    added    = "+",
    modified = "~",
    removed  = "-",
}

local diagnostics_signs = {
    error = "E",
    warn = "W",
    info = "I",
    hint = "H"
}

local function diff_source ()
    local status = vim.b.gitsigns_status_dict or {}

    return {
        added = status.added or 0,
        modified = status.changed or 0,
        removed = status.removed or 0,
    }
end

local function format_filename ( filename, ctx )
    return string.gsub( filename, "\\", "/" )
end

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
                    theme = "powerline_dark",
                    component_separators = "",
                    section_separators = "",
                    disabled_filetypes = {
                        statusline = {
                            "unite",
                            "undotree",
                            "help",
                            "man",
                            "trouble",
                        },
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
                    lualine_a = {
                        "mode"
                    },
                    lualine_b = {
                        { "branch", icon = "" },
                        { "diff", colored = false, symbols = diff_signs, source = diff_source },
                        {
                            "diagnostics",
                            -- sources = { "nvim_diagnostic", "nvim_workspace_diagnostic", "nvim_lsp" },
                            symbols = diagnostics_signs,
                            colored = false,
                            always_visible = false,
                        },
                    },
                    lualine_c = {
                        {
                            "filename",
                            path = 4,
                            fmt = format_filename,
                        }
                    },
                    lualine_x = {},
                    lualine_y = {
                        "filetype",
                        { "encoding", show_bomb = true },
                        "new.fileformat"
                    },
                    lualine_z = {
                        "new.progress",
                        "new.location"
                    }
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {
                        { "branch", icon = "⎇" },
                        { "diff", colored = false, symbols = diff_signs, source = diff_source },
                        {
                            "diagnostics",
                            -- sources = { "nvim_diagnostic", "nvim_workspace_diagnostic", "nvim_lsp" },
                            symbols = diagnostics_signs,
                            colored = false,
                            always_visible = false,
                        },
                    },
                    lualine_c = {
                        {
                            "filename",
                            path = 4,
                            fmt = format_filename,
                        }
                    },
                    lualine_x = {},
                    lualine_y = {
                        "filetype",
                        { "encoding", show_bomb = true },
                        "new.fileformat"
                    },
                    lualine_z = {
                        "new.progress",
                        "new.location"
                    }
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
                            -- fmt = function ( filename, ctx )
                            --     return filename
                            -- end,
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
