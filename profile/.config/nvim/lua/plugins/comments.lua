local toggle_linewise
local toggle_blockwise

return {
    {
        "numtostr/comment.nvim",
        dependencies = {
            "joosepalviste/nvim-ts-context-commentstring"
        },
        keys = {
            {
                "<Leader>c",
                function ()
                    require( "Comment.api" ).toggle.linewise.current()
                    vim.cmd( "normal! j" )
                end,
                mode = { "n", "i" },
                desc = "Toggle comment for the current line",
            },
            {
                "<Leader><Leader>c",
                function ()
                    require( "Comment.api" ).toggle.blockwise.current()
                    vim.cmd( "normal! j" )
                end,
                mode = { "n", "i" },
                desc = "Toggle block comment for the current line",
            },
            {
                "<Leader>c",
                function ()
                    if not toggle_linewise then
                        toggle_linewise = require( "Comment.api" ).call( "toggle.linewise", "g@" )
                    end

                    return toggle_linewise()
                end,
                mode = { "v" },
                desc = "Toggle comments for the selected lines",
                expr = true,
            },
            {
                "<Leader><Leader>c",
                function ()
                    if not toggle_blockwise then
                        toggle_blockwise = require( "Comment.api" ).call( "toggle.blockwise", "g@" )
                    end

                    return toggle_blockwise()
                end,
                mode = { "v" },
                desc = "Toggle block comment for the selection",
                expr = true,
            },
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

                -- XXX: escape commented strings
                -- XXX: https://github.com/numToStr/Comment.nvim/issues/503
                -- "*/" -> "*\/"
                -- "-->" -> "--\>"
                -- post_hook = function ( ctx )
                -- end
            } )

            local ft = require( "Comment.ft" )

            ft.set( "dosbatch", ":: %s" )
            ft.set( "nginx", "# %s" )
            ft.set( "powershell", "# %s" )
        end,
    },
}
