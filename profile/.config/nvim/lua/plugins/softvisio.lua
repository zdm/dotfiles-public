return {
    {
        "zdm/softvisio.nvim",
        dev = true,
        dependencies = {
            "trouble.nvim",
        },
        cmd = "S",
        keys = {
            {
                "<Leader>sd",
                "<ESC>:S lint format<CR>",
                mode = { "n", "i", "v", "s" },
                desc = "Lint buffer using default rules",
            },
            {
                "<Leader>sf",
                "<ESC>:S lint lint<CR>",
                mode = { "n", "i", "v", "s" },
                desc = "Lint buffer",
            },
            {
                "<Leader>sc",
                "<ESC>:S lint compress<CR>",
                mode = { "n", "i", "v", "s" },
                desc = "Compress buffer",
            },
            {
                "<Leader>so",
                "<ESC>:S lint obfuscate<CR>",
                mode = { "n", "i", "v", "s" },
                desc = "Obfuscate buffer",
            },
        },
        config = function ()
            require( "softvisio" ).setup( {
                ignored_filetypes = require( "utils" ).ignored_filetypes,
            } )
        end
    }
}
