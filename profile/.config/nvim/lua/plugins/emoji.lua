return {
    {
        "allaman/emoji.nvim",
        version = "*",
        config = function ()
            require( "emoji" ).setup( {
                enable_cmp_integration = true,
            } )
        end,
    }
}
