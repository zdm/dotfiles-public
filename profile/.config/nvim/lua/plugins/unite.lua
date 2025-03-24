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
    },
    { "shougo/neomru.vim" },
    {
        "shougo/unite-outline",
        config = function ()
            vim.keymap.set( { "n", "i", "v" }, "<F8>", function ()
                vim.cmd( "Unite -buffer-name=outline -toggle -vertical -direction=botright -winwidth=60 -start-insert -no-restore outline" )
            end, { noremap = true, silent = true } )
        end
    },
}
