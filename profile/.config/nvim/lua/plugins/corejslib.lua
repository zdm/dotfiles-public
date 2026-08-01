return {
    {
        "neovim-plugins/corejslib.nvim",
        tag = "latest",
        dev = true,
        dependencies = {
            "telescope.nvim",
        },
        cmd = "S",
        keys = {
            {
                "<Leader>sd",
                "<CMD>S lint lint<CR>",
                mode = { "n", "i", "v", "s" },
                desc = "Lint buffer",
            },
            {
                "<Leader>sf",
                "<CMD>S lint format<CR>",
                mode = { "n", "i", "v", "s" },
                desc = "Lint buffer using default rules",
            },
            {
                "<Leader>sc",
                "<CMD>S lint compress<CR>",
                mode = { "n", "i", "v", "s" },
                desc = "Compress buffer",
            },
            {
                "<Leader>so",
                "<CMD>S lint obfuscate<CR>",
                mode = { "n", "i", "v", "s" },
                desc = "Obfuscate buffer",
            },
        },
        config = function ()
            require( "corejslib" ).setup( {
                ignored_filetypes = require( "utils" ).ignored_filetypes,
            } )
        end
    }
}
