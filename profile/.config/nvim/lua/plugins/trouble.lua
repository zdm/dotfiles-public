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
                "<Leader>xx",
                "<CMD>Trouble diagnostics toggle<CR>",
                mode = { "n", "i", "v", "s" },
                desc = "Diagnostics (Trouble)",
            },
        }
    }
}
