return {
    {
        "l3mon4d3/luasnip",
        enabled = false,
        version = "*",
        -- build = "make install_jsregexp"
        config = function ()
            require( "luasnip" ).setup( {
                region_check_events = "InsertEnter,CursorMoved",
                delete_check_events = "TextChanged,InsertLeave",
            } )

            require( "luasnip-yaml" ).setup();
        end
    }
}
