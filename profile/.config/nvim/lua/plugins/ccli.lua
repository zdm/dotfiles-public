return {
    {
        "neovim-plugins/ccli.nvim",
        tag = "latest",
        dev = true,
        dependencies = {
            "telescope.nvim",
        },
        cmd = "Ccli",
        keys = {
            {
                "<Leader>sd",
                "<CMD>Ccli lint lint<CR>",
                mode = { "n", "i", "v", "s" },
                desc = "Lint buffer",
            },
            {
                "<Leader>sf",
                "<CMD>Ccli lint format<CR>",
                mode = { "n", "i", "v", "s" },
                desc = "Lint buffer using default rules",
            },
            {
                "<Leader>sc",
                "<CMD>Ccli lint compress<CR>",
                mode = { "n", "i", "v", "s" },
                desc = "Compress buffer",
            },
            {
                "<Leader>so",
                "<CMD>Ccli lint obfuscate<CR>",
                mode = { "n", "i", "v", "s" },
                desc = "Obfuscate buffer",
            },
        },
        config = function ()
            require( "ccli" ).setup( {
                ignored_filetypes = require( "utils" ).ignored_filetypes,
            } )
        end
    }
}
