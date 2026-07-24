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
        "copilotc-nvim/copilotchat.nvim",
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
