vim.api.nvim_create_user_command( "MasonFullUpdate", function ()
    local registry = require( "mason-registry" );

    vim.notify( "Updating Mason registry..." );

    registry.update( function ( success )
        if not success then
            vim.notify( "Mason registry update failed", vim.log.levels.ERROR );
        else
            vim.notify( "Mason registry updated" );

            vim.cmd( "Mason" );
        end
    end );
end, {} )

return {
    {
        "mason-org/mason.nvim",
        opts = {},
    },
    {
        "neovim/nvim-lspconfig",
    },
    {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            "mason.nvim",
            "nvim-lspconfig",
        },
        opts = {
            ensure_installed = {
                "copilot",
            },
            automatic_enable = {
                exclude = {
                    "copilot",
                },
            },
        },
    },
    {
        "copilotlsp-nvim/copilot-lsp",
        -- enabled = false,
        dependencies = {
            "mason-lspconfig.nvim",
        },
        event = "VeryLazy",
        keys = {
            {
                "<Tab>",
                function ()
                    local nes = require( "copilot-lsp.nes" )
                    local state = vim.b[ vim.api.nvim_get_current_buf() ].nes_state

                    if not state then
                        return;
                    elseif nes.walk_cursor_start_edit() then
                        return;
                    elseif nes.apply_pending_nes() then
                        nes.walk_cursor_end_edit();
                    end
                end,
                mode = { "n" },
                desc = "Accept Copilot NES suggestion",
                expr = true,
            },
            {
                "<Esc>",
                function ()
                    local nes = require( "copilot-lsp.nes" )

                    if not nes.clear() then
                        return "<Esc>";
                    end
                end,
                mode = { "n" },
                desc = "Clear Copilot NES suggestion",
                expr = true,
            },
        },
        init = function ()
            vim.g.copilot_nes_debounce = 100
        end,
        config = function ()
            vim.lsp.enable( "copilot_ls" )
        end,
    },
}
