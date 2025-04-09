return {
    {
        "luukvbaal/statuscol.nvim",
        -- enabled = false,
        config = function ()
            local builtin = require( "statuscol.builtin" )

            require( "statuscol" ).setup( {
                segments = {
                    {
                        text = { builtin.foldfunc },
                        click = "v:lua.ScFa"
                    },
                    {
                        sign = {
                            name = { ".*" },
                            text = { ".*" },
                            namespace = { ".*" },
                            maxwidth = 1,
                            colwidth = 2,
                            auto = true,
                            wrap = true,
                        },
                        click = "v:lua.ScSa"
                    },
                    {
                        text = { " ", "%l", " " },
                        click = "v:lua.ScLa",
                    },
                }
            } )
        end,
    }
}
