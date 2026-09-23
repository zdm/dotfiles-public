return {
    {
        "williamboman/mason.nvim",
        opts = {},
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "mason.nvim",
        },
        opts = {
            automatic_enable = false,
            ensure_installed = {
                "copilot",
            },
        },
    },
    {
        "copilotlsp-nvim/copilot-lsp",
        init = function ()
            vim.g.copilot_nes_debounce = 500

            -- vim.keymap.set( "n", "<tab>", function ()
            --     local bufnr = vim.api.nvim_get_current_buf()
            --     local state = vim.b[ bufnr ].nes_state

            --     if state then
            --         return require( "copilot-lsp.nes" ).apply_pending_nes()
            --             and require( "copilot-lsp.nes" ).walk_cursor_end_edit()
            --     end

            --     return "<tab>"
            -- end, { expr = true } )
        end,
        config = function ()
            vim.lsp.enable( "copilot_ls" )
        end,
    },
    {
        "folke/sidekick.nvim",
        -- enabled = false,
        keys = {
            {
                "<tab>",
                function ()
                    if not require( "sidekick" ).nes_jump_or_apply() then
                        return "<Tab>"
                    end
                end,
                expr = true,
                desc = "Goto/Apply Next Edit Suggestion",
            },
            {
                "<c-.>",
                function () require( "sidekick.cli" ).focus() end,
                desc = "Sidekick Focus",
                mode = { "n", "t", "i", "x" },
            },
            {
                "<leader>aa",
                function () require( "sidekick.cli" ).toggle( { name = "copilot", focus = true } ) end,
                -- function () require( "sidekick.cli" ).toggle() end,
                desc = "Sidekick Toggle CLI",
            },
            {
                "<leader>as",
                function () require( "sidekick.cli" ).select( { filter = { installed = true } } ) end,
                -- function () require( "sidekick.cli" ).select() end,
                desc = "Select CLI",
            },
            {
                "<leader>ad",
                function () require( "sidekick.cli" ).close() end,
                desc = "Detach a CLI Session",
            },
            {
                "<leader>at",
                function () require( "sidekick.cli" ).send( { msg = "{this}" } ) end,
                mode = { "x", "n" },
                desc = "Send This",
            },
            {
                "<leader>af",
                function () require( "sidekick.cli" ).send( { msg = "{file}" } ) end,
                desc = "Send File",
            },
            {
                "<leader>av",
                function () require( "sidekick.cli" ).send( { msg = "{selection}" } ) end,
                mode = { "x" },
                desc = "Send Visual Selection",
            },
            {
                "<leader>ap",
                function () require( "sidekick.cli" ).prompt() end,
                mode = { "n", "x" },
                desc = "Sidekick Select Prompt",
            },
        },
        opts = {
            nes = {
                -- enabled = false,
            },
            -- cli = {
            --     mux = {
            --         enabled = true,
            --         backend = "zellij",
            --     },
            -- },
        },
    },
}
