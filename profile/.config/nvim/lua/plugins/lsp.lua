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
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
            "mason.nvim",
            "neovim/nvim-lspconfig",
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
            "neovim/nvim-lspconfig",
        },
        init = function ()
            vim.g.copilot_nes_debounce = 100
        end,
        config = function ()
            vim.lsp.enable( "copilot_ls" )

            local nes = require( "copilot-lsp.nes" );

            vim.keymap.set( { "n" }, "<Tab>", function ()
                local state = vim.b[ vim.api.nvim_get_current_buf() ].nes_state;

                if not state then
                    return "<Tab>";
                end

                if nes.walk_cursor_start_edit() then
                    return;
                end

                if nes.apply_pending_nes() then
                    nes.walk_cursor_end_edit();
                end
            end, {
                desc = "Accept Copilot NES suggestion",
                expr = true,
            } );

            vim.keymap.set( { "n" }, "<Esc>", function ()
                if not nes.clear() then
                    return "<Esc>";
                end
            end, {
                desc = "Clear Copilot NES suggestion",
                expr = true,
            } );
        end,
    },
}
