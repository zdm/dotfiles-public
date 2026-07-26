return {
    {
        "github/copilot.vim",
        enabled = false,
    },
    {
        "zbirenbaum/copilot.lua",
        -- enabled = false,
        dependencies = {
            {
                "copilotlsp-nvim/copilot-lsp",
            },
        },
        cmd = "Copilot",
        event = "InsertEnter",
        config = function ()
            require( "copilot" ).setup( {
                suggestion = {
                   enabled = true,
                    auto_trigger = true,
                },
            } )
        end
    },
    {
        "zbirenbaum/copilot-cmp",
        config = function ()
            require( "copilot_cmp" ).setup()
        end
    },
    {
        -- DOCS: https://codecompanion.olimorris.dev/
        "olimorris/codecompanion.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = {
            opts = {
                -- log_level = "DEBUG", -- or "TRACE"
            },
        },
    },
    {
        "copilotc-nvim/copilotchat.nvim",
        enabled = false,
        dependencies = {
            {
                "nvim-lua/plenary.nvim",
            },
        },
        -- build = "make tiktoken",
        opts = {
            -- model = "Claude Sonnet 5"
        },
    },
}
