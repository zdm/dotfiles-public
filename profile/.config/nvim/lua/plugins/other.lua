return {
    {
        "powerman/vim-plugin-viewdoc",
        init = function ()
            vim.g.viewdoc_openempty = 1

            -- if !exists( "g:no_plugin_abbrev" ) && !exists( "g:no_viewdoc_abbrev" )
            --     cnoreabbrev <expr> h  getcmdtype() == ":" && getcmdline() == "h"  ? "ViewDocHelp"  : "h"
            --     cnoreabbrev <expr> h! getcmdtype() == ":" && getcmdline() == "h!" ? "ViewDocHelp"  : "h!"

            --     cnoreabbrev <expr> pd  getcmdtype() == ":" && getcmdline() == "pd"  ? "ViewDocPerl"  : "pd"
            --     cnoreabbrev <expr> pd! getcmdtype() == ":" && getcmdline() == "pd!" ? "ViewDocPerl"  : "pd!"
            -- endif
        end
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        config = function ()
            require( "ibl" ).setup( {
                indent = {
                    char = "┊"
                },
                scope = {
                   enabled = false,
                },
            } )
        end
    },
    { "uguu-org/vim-matrix-screensaver" },
    { "zhimsel/vim-stay" },
    {
        "lyokha/vim-xkbswitch",
        dependencies = {
            "dexp/xkb-switch-win"
        },
        init = function ()
            vim.g.XkbSwitchEnabled = 1
            vim.g.XkbSwitchIMappings = { "ru" }
            vim.g.XkbSwitchIMappingsSkipFt = { "tex" }
            vim.g.XkbSwitchNLayout = "US"
            vim.g.XkbSwitchILayout = "US"

            if vim.fn.has( "win64" ) == 1 then
                vim.g.XkbSwitchLib = vim.fn.stdpath( "data" ) .. "/lazy/xkb-switch-win/bin/libxkbswitch64.dll"
            elseif vim.fn.has( "win32" ) == 1 then
                vim.g.XkbSwitchLib = vim.fn.stdpath( "data" ) .. "/lazy/xkb-switch-win/bin/libxkbswitch32.dll"
            else
                vim.g.XkbSwitchLib = ""
            end
        end
    },
}
