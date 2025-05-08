return {
    {
        "rcarriga/nvim-notify",
        config = function ()
            local notify = require( "notify" )

            notify.setup( {
                render = "default",
                top_down = false,
            } );

            -- vim.notify = notify
        end,
    }
}
