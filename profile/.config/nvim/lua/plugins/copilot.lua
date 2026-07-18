return {
    {
        "github/copilot.vim",
        enabled = false,
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
