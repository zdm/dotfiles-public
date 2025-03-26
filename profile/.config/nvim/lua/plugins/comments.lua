return {
    {
        "numtostr/comment.nvim",
        dependencies = {
            "joosepalviste/nvim-ts-context-commentstring"
        },
        config = function ()
            require( "ts_context_commentstring" ).setup( {
                enable_autocmd = false,
            } )

            require( "Comment" ).setup( {
                padding = true,
                sticky = true,
                ignore = "^$",
                mappings = {
                    basic = false,
                    extra = false,
                },
                pre_hook = require( "ts_context_commentstring.integrations.comment_nvim" ).create_pre_hook(),
            } )

            local api = require( "Comment.api" )
            local config = require( "Comment.config" ):get()

            vim.keymap.set( { "n", "i" }, "<Leader>c", function ()
                api.toggle.linewise.current()
                vim.cmd( "normal! j" )
            end )

            vim.keymap.set( "v", "<Leader>c", api.call( "toggle.linewise", "g@" ), { expr = true } )
            vim.keymap.set( "v", "<Leader>cc", api.call( "toggle.blockwise", "g@" ), { expr = true } )

            local ft = require( "Comment.ft" )

            ft.set( "dosbatch", ":: %s" )
            ft.set( "nginx", "# %s" )
            ft.set( "powershell", "# %s" )

            -- XXX
            -- let g:tcomment#replacements_xml = {
            -- \   '<!--': '<!-&#45;',
            -- \   '-->': '&#45;->'
            -- \ }
        end,
    },
}
