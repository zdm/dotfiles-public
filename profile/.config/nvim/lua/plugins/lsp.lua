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
        config = function ()
            require( "mason-lspconfig" ).setup( {
                ensure_installed = {
                    -- "copilot",
                },
                automatic_enable = {
                    -- "copilot",
                    exclude = {
                        "copilot",
                    },
                },
            } );

            vim.lsp.enable( "copilot" );
        end,
    },
}
