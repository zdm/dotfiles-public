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
        enabled = false,
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
}
