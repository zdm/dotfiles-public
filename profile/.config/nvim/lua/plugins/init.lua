return {
    {
        "shougo/unite.vim",
        init = function ()
            vim.g.unite_data_directory = vim.fn.stdpath( "data" ) .. "/unite"
            vim.g.unite_source_bookmark_directory = vim.fn.stdpath( "config" ) .. "/unite/bookmark"
            vim.g.unite_force_overwrite_statusline = 0
            vim.g.unite_cursor_line_highlight = "CursorLine"
            vim.g.unite_source_menu_menus = vim.empty_dict()
            vim.g.unite_winheight = 20
            vim.g.unite_winwidth = 40
            vim.g.unite_split_rule = "botright"
        end,
    },
    { "shougo/neomru.vim" },
    { "shougo/unite-outline" },
    { "mbbill/undotree" },
    { "powerman/vim-plugin-viewdoc" },
    { "mhinz/vim-signify" },
    { "yggdroot/indentline" },

    -- airline
    { "vim-airline/vim-airline" },
    { "vim-airline/vim-airline-themes" },

    -- comments
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

            -- XXX
            -- let g:tcomment#replacements_xml = {
            -- \   '<!--': '<!-&#45;',
            -- \   '-->': '&#45;->'
            -- \ }
        end,
    },

    { "tpope/vim-fugitive" },
    { "uguu-org/vim-matrix-screensaver" },
    { "vim-scripts/dirdiff.vim" },
    { "zhimsel/vim-stay" },

    -- completion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-vsnip",
            "hrsh7th/vim-vsnip",
            "hrsh7th/cmp-calc",
        },
        init = function ()
            vim.o.omnifunc = "syntaxcomplete#Complete"
            vim.o.completeopt = "menuone,noselect"
            vim.opt.complete:remove( { "i" } )
            vim.opt.iskeyword:append( { ":" } )

            vim.g.vsnip_snippet_dir = vim.fn.stdpath( "config" ) .. "/vsnip"
        end,
        config = function ()
            local cmp = require( "cmp" )

            cmp.setup( {
                snippet = {
                    expand = function ( args )
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
                } )
            } )
        end
    },

    {
        "lyokha/vim-xkbswitch",
        dependencies = {
            "dexp/xkb-switch-win"
        },
        init = function ()
            if vim.fn.has( "win64" ) == 1 then
                vim.g.XkbSwitchLib = vim.fn.stdpath( "data" ) .. "/lazy/xkb-switch-win/bin/libxkbswitch64.dll"
            elseif vim.fn.has( "win32" ) == 1 then
                vim.g.XkbSwitchLib = vim.fn.stdpath( "data" ) .. "/lazy/xkb-switch-win/bin/libxkbswitch32.dll"
            else
                vim.g.XkbSwitchLib = ""
            end
        end
    },
}
