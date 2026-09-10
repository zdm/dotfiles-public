return {
    {
        "l3mon4d3/luasnip",
        version = "*",
        -- build = "make install_jsregexp"
        config = function ()
            require( "luasnip" ).config.set_config( {
            } )

            require( "luasnip-yaml" ).setup();
        end
    }
}
