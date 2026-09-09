return {
    {
        "neovim-plugins/zcli.nvim",
        tag = "latest",
        dev = true,
        dependencies = {
            "telescope.nvim",
        },
        cmd = "Zcli",
        keys = {
            {
                "<Leader>sd",
                "<CMD>Zcli lint lint<CR>",
                mode = { "n", "i", "v", "s" },
                desc = "Lint buffer",
            },
            {
                "<Leader>sf",
                "<CMD>Zcli lint format<CR>",
                mode = { "n", "i", "v", "s" },
                desc = "Lint buffer using default rules",
            },
            {
                "<Leader>sc",
                "<CMD>Zcli lint compress<CR>",
                mode = { "n", "i", "v", "s" },
                desc = "Compress buffer",
            },
            {
                "<Leader>so",
                "<CMD>Zcli lint obfuscate<CR>",
                mode = { "n", "i", "v", "s" },
                desc = "Obfuscate buffer",
            },
        },
        config = function ()
            require( "zcli" ).setup( {
                ignored_filetypes = require( "utils" ).ignored_filetypes,
            } )
        end
    }
}
