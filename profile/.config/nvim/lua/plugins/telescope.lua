return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "octarect/telescope-menu.nvim",
        },
        cmd = "Telescope",
        keys = {
            {
                "<F2>",
                "<CMD>Telescope menu prompt_title=Commands results_title= theme=ivy layout_config={height=10}<CR>",
                mode = { "n", "i", "v" },
                desc = "Helper menu",
            },
            {
                "<F3>",
                "<CMD>Telescope find_files<CR>",
                mode = { "n", "i", "v" },
                desc = "Telescope files",
            },
            {
                "<F4>",
                "<CMD>Telescope buffers<CR>",
                mode = { "n", "i", "v" },
                desc = "Telescope buffers",
            },
            {
                "<Leader>xx",
                "<CMD>Telescope diagnostics bufnr=0<CR>",
                mode = { "n", "i", "v", "s" },
                desc = "Open diagnostics",
            },

        },
        config = function ()
            local telescope = require( "telescope" )

            telescope.setup( {
                pickers = {
                    diagnostics = {
                        sort_by = "severity",
                        line_width = "full",
                        sorting_strategy = "ascending",

                        layout_strategy = "vertical",
                        layout_config = {
                            height = 0.999,
                            width = 0.99,
                            preview_height = 0.6,
                            preview_cutoff = 0,
                        },

                        -- theme = "ivy",
                        -- layout_config = {
                        --     height = 10,
                        -- },
                    },
                },
                extensions = {
                    menu = {
                        default = {
                            items = {
                                { "Update plugins", "Lazy sync" },
                                { "set ft=javascript", "set ft=javascript" },
                                { "set ft=json", "set ft=json" },
                                { "setlocal ff=unix", "setlocal ff=unix" },
                                { "Telescope pickers", "Telescope builtin" },
                                { "Edit snippets", "VsnipOpen" },
                                { "Open buffer in the browser", "S browser" },
                                { "spellchecker on", "setlocal spell spelllang=ru_yo,en_us" },
                                { "spellchecker off", "setlocal nospell" },
                                { "Matrix screensaver", "Matrix" },
                            },
                        },
                    },
                },
            } )

            -- configure cursor line
            vim.api.nvim_set_hl( 0, "TelescopeSelection", {
                bg = "Grey15",
            } )
        end
    },
}
