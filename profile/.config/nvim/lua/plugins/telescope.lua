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
                "<CMD>Telescope menu theme=ivy layout_config={height=10}<CR>",
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
                "<CMD>Telescope diagnostics<CR>",
                mode = { "n", "i", "v", "s" },
                desc = "Open diagnostics",
            },

        },
        config = function ()
            local telescope = require( "telescope" )

            telescope.setup( {
                pickers = {
                    diagnostics = {
                        theme = "ivy",
                        layout_config = {
                            height = 10,
                        },
                    },
                },
                extensions = {
                    menu = {
                        default = {
                            items = {
                                { "update plugins", "Lazy sync" },
                                { "set ft=javascript", "set ft=javascript" },
                                { "set ft=json", "set ft=json" },
                                { "pickers", "Telescope builtin" },
                                { "edit snippets", "VsnipOpen" },
                                { "open buffer in the browser", "S browser" },
                                { "spellchecker on", "setlocal spell spelllang=ru_yo,en_us" },
                                { "spellchecker off", "setlocal nospell" },
                                { "set linendings to UNIX format", "setlocal ff=unix" },
                                { "matrix screensaver", "Matrix" },
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
