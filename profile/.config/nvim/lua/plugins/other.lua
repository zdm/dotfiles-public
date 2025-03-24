return {
    {
        "mbbill/undotree",
        init = function ()
            vim.g.undotree_WindowLayout = 2
            vim.g.undotree_SplitWidth = 40
            vim.g.undotree_SetFocusWhenToggle = 1
            vim.g.undotree_DiffAutoOpen = 0
        end,
        config = function ()
            vim.keymap.set( { "n", "i", "v" }, "<F10>", function ()
                vim.cmd( "UndotreeToggle" )
            end, { noremap = true, silent = true } )
        end
    },
    { "powerman/vim-plugin-viewdoc" },
    { "mhinz/vim-signify" },
    {
        "yggdroot/indentline",
        init = function ()
            vim.g.indentLine_enabled = 1
            -- vim.g.indentLine_char = "│"
            -- vim.g.indentLine_showFirstIndentLevel = 1
            -- vim.g.indentLine_fileType = { "pl", "pm", "perl", "js" }
            vim.g.indentLine_fileTypeExclude = { "json", "markdown" }
            vim.g.indentLine_faster = 1
        end,
        config = function ()
            vim.keymap.set( { "n", "i", "v" }, "<Leader>ii", function ()
                vim.cmd( "IndentLinesToggle" )
            end, { noremap = true, silent = true } )
        end
    },
    { "tpope/vim-fugitive" },
    { "uguu-org/vim-matrix-screensaver" },
    { "vim-scripts/dirdiff.vim" },
    { "zhimsel/vim-stay" },
    {
        "lyokha/vim-xkbswitch",
        dependencies = {
            "dexp/xkb-switch-win"
        },
        init = function ()
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
