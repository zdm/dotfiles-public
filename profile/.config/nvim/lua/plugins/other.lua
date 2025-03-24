return {
    { "mbbill/undotree" },
    { "powerman/vim-plugin-viewdoc" },
    { "mhinz/vim-signify" },
    { "yggdroot/indentline" },
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
