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
            vim.g.copilot_nes_debounce = 500
        end,
        config = function ()
            vim.lsp.enable( "copilot_ls" )
        end,
    },
}
