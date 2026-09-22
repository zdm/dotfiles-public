return {
    {
        "williamboman/mason.nvim",
        opts = {},
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
        },
        opts = {
            ensure_installed = {
                "copilot",
            },
            automatic_enable = false,
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
        keys1 = {
            {
                "<tab>",
                function ()
                    if not require("sidekick").nes_jump_or_apply() then
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
                function () require( "sidekick.cli" ).toggle() end,
                desc = "Sidekick Toggle CLI",
            },
            {
                "<leader>as",
                function () require( "sidekick.cli" ).select() end,
                -- Or to select only installed tools:
                -- require( "sidekick.cli" ).select( { filter = { installed = true } } )
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
            -- {
            --     "<leader>ac",
            --     function () require( "sidekick.cli" ).toggle( { name = "claude", focus = true } ) end,
            --     desc = "Sidekick Toggle Claude",
            -- },
        },
        opts = {
            cli = {
                mux = {
                    backend = "zellij",
                    enabled = true,
                },
            },
        },
    },
}
