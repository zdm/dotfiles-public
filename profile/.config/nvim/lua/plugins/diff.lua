return {
    {
        "sindrets/diffview.nvim",
        dev = true,
        config = function ()
            local actions = require( "diffview.actions" )

            require( "diffview" ).setup( {
                git_cmd = { vim.fn.has( "win32" ) == 1 and "git.exe" or "git" },
                use_icons = false,
            } )
        end
    },
}
