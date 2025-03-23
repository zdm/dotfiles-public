return {
    { "Shougo/unite.vim" },
    { "Shougo/neomru.vim" },
    { "Shougo/unite-outline" },
    { "mbbill/undotree" },
    { "powerman/vim-plugin-viewdoc" },
    { "mhinz/vim-signify" },
    { "Yggdroot/indentLine" },

    -- airline
    { "vim-airline/vim-airline" },
    { "vim-airline/vim-airline-themes" },

    -- "hook_post_update": "TSUpdate"
    {
        "nvim-treesitter/nvim-treesitter",
        config = function ()
        end
    },

    { "foalford/vim-markdown-folding" },

    -- comments
    {
        "numToStr/Comment.nvim",
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring"
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

            -- XXX
            -- let g:tcomment#replacements_xml = {
            -- \   '<!--': '<!-&#45;',
            -- \   '-->': '&#45;->'
            -- \ }
        end,
    },
    { "JoosepAlviste/nvim-ts-context-commentstring" },

    { "tpope/vim-fugitive" },
    { "uguu-org/vim-matrix-screensaver" },
    { "vim-scripts/DirDiff.vim" },
    { "zhimsel/vim-stay" },

    -- completion
    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-vsnip" },
    { "hrsh7th/vim-vsnip" },
    { "hrsh7th/cmp-calc" },

    -- "depends": "DeXP/xkb-switch-win"
    -- { "lyokha/vim-xkbswitch" },
    -- { "DeXP/xkb-switch-win" },
}
