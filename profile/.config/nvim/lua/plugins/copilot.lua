return {
    {
        "github/copilot.vim",
        enabled = false,
    },
    {
        "zbirenbaum/copilot.lua",
        dependencies = {
            {
                "copilotlsp-nvim/copilot-lsp",
            },
        },
        cmd = "Copilot",
        event = "InsertEnter",
        config = function ()
            require( "copilot" ).setup( {} )
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
