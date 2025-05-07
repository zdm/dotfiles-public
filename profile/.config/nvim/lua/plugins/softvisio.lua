return {
    {
        "zdm/softvisio.nvim",
        dev = true,
        dependencies = {
            "trouble.nvim",
        },
        lazy = false,
        cmd = "S",
        keys = {
            {
                "<leader>sd",
                "<esc>:S lint format<cr>",
                mode = { "n", "i", "v", "s" },
                desc = "Lint buffer using default rules",
            },
            {
                "<leader>sf",
                "<esc>:S lint lint<cr>",
                mode = { "n", "i", "v", "s" },
                desc = "Lint buffer",
            },
            {
                "<leader>sc",
                "<esc>:S lint compress<cr>",
                mode = { "n", "i", "v", "s" },
                desc = "Compress buffer",
            },
            {
                "<leader>so",
                "<esc>:S lint obfuscate<cr>",
                mode = { "n", "i", "v", "s" },
                desc = "Obfuscate buffer",
            },
        },
        config = function ()
            require( "softvisio" ).setup( {
                ignored_filetypes = {
                    "DiffViewFileHistory",
                    "DiffViewFiles",
                    "gitgraph",
                    "help",
                    "man",
                    "trouble",
                    "undotree",
                    "unite",
                },
            } )
        end
    }
}
