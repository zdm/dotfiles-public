return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
        },
        cmd = "Telescope",
        keys = {
            {
                "<F4>",
                "<CMD>Telescope buffers<CR>",
                mode = { "n", "i", "v" },
                desc = "Telescope buffers",
            },
        },
        config = function ()
        end
    }
}
