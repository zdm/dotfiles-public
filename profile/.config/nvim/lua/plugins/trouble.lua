return {
    {
        "folke/trouble.nvim",
        opts = {
            auto_close = true,
            focus = true,
            warn_no_results = false,
            open_no_results = false,
        },
        cmd = "Trouble",
        keys = {
            {
                "<leader>xx",
                "<cmd>Trouble diagnostics toggle<cr>",
                mode = { "n", "i" },
                desc = "Diagnostics (Trouble)",
            },
        }
    }
}
