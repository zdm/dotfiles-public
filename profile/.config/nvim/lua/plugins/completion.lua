return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-calc",
            "hrsh7th/cmp-vsnip",
            {
                "hrsh7th/vim-vsnip",
                init = function ()
                    vim.g.vsnip_snippet_dir = vim.fn.stdpath( "config" ) .. "/vsnip"

                    vim.g.vsnip_filetypes = {
                        [ "html/javascript" ] = { "javascript", "html/javascript" },
                        [ "vue" ] = { "html", "vue/html" },
                        [ "vue/javascript" ] = { "javascript", "html/javascript", "vue/javascript" },
                    }
                end
            },
        },
        init = function ()
            vim.o.omnifunc = "syntaxcomplete#Complete"
            vim.o.completeopt = "menuone,noselect"
            vim.opt.complete:remove( { "i" } )
            vim.opt.iskeyword:append( { ":" } )
        end,
        config = function ()
            local cmp = require( "cmp" )

            cmp.setup( {
                snippet = {
                    expand = function ( args )
                        -- XXX native snippet
                        -- vim.snippet.expand( args.body )

                        vim.fn[ "vsnip#anonymous" ]( args.body )
                    end,
                },
                mapping = cmp.mapping.preset.insert( {
                    [ "<Up>" ] = function ( fallback )
                        if cmp.visible() then
                            cmp.abort()
                        end

                        fallback()
                    end,
                    [ "<Down>" ] = function ( fallback )
                        if cmp.visible() then
                            cmp.abort()
                        end

                        fallback()
                    end,
                    [ "<C-Up>" ] = cmp.mapping.select_prev_item( { behavior = cmp.SelectBehavior.Select } ),
                    [ "<C-Down>" ] = cmp.mapping.select_next_item( { behavior = cmp.SelectBehavior.Select } ),
                    [ "<C-Space>" ] = cmp.mapping.complete(),
                    [ "<C-e>" ] = cmp.mapping.abort(),
                    [ "<CR>" ] = cmp.mapping.confirm( { select = false } ),
                } ),
                sources = cmp.config.sources( {
                    { name = "vsnip" },
                    { name = "calc" },
                    { name = "emoji" },
                } )
            } )
        end
    },
}
