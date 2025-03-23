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

    {
        "nvim-treesitter/nvim-treesitter",
        config = function ()
            require( "nvim-treesitter.install" ).prefer_git = false

            require( "nvim-treesitter.configs" ).setup( {
                ensure_installed = {
                    "awk",
                    "bash",
                    "c",
                    "cmake",
                    "comment",
                    "cpp",
                    "css",
                    "csv",
                    "diff",
                    "dockerfile",
                    "editorconfig",
                    "embedded_template",
                    "forth",
                    "git_config",
                    "gitattributes",
                    "gitignore",
                    "gpg",
                    "graphql",
                    "html",
                    "ini",
                    "javascript",
                    "jsdoc",
                    "json",
                    "json5",
                    "lua",
                    "make",
                    "markdown",
                    "markdown_inline",
                    "nginx",
                    "pem",
                    "perl",
                    "po",
                    "pod",
                    "powershell",
                    "query",
                    "scss",
                    "sql",
                    "ssh_config",
                    "toml",
                    "tsv",
                    "typescript",
                    "vim",
                    "vimdoc",
                    "vue",
                    "xml",
                    "yaml"
                },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = false,
                },
                indent = {
                    enable = true
                },
                incremental_selection = {
                    enable = true,
                --     keymaps = {
                --         init_selection = "gnn", -- set to `false` to disable one of the mappings
                --         node_incremental = "grn",
                --         scope_incremental = "grc",
                --         node_decremental = "grm",
                --     },
                },
            } )

            -- NOTE https://github.com/nvim-treesitter/nvim-treesitter/tree/master/queries
            require( "vim.treesitter.query" ).set( "javascript", "folds", [[
                [
                    (arrow_function)
                    (function_expression)
                    (function_declaration)
                    (method_definition)
                    (generator_function)
                    (generator_function_declaration)
                    (template_string)
                    (comment)
                ] @fold
            ]] )

            require( "vim.treesitter.query" ).set( "vim", "folds", [[
                [
                    (function_definition)
                    (lua_statement)
                    (ruby_statement)
                    (python_statement)
                    (perl_statement)
                    (autocmd_statement)
                ] @fold
            ]] )

            require( "vim.treesitter.query" ).set( "lua", "folds", [[
                [
                    (function_declaration)
                    (function_definition)
                ] @fold
            ]] )

            require( "vim.treesitter.query" ).set( "bash", "folds", [[
                [
                    (function_definition)
                    (heredoc_redirect)
                ] @fold
            ]] )

            vim.api.nvim_create_autocmd( { "FileType" }, {
                callback = function ()
                    if require( "nvim-treesitter.parsers" ).has_parser() then
                        vim.bo.syntax = "off"
                        vim.wo.foldmethod = "expr"

                        if vim.bo.filetype == "markdown" then
                            vim.wo.foldexpr = "StackedMarkdownFolds()"
                        else
                            vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
                        end
                    else
                        vim.bo.syntax = "on"
                        vim.wo.foldmethod = "syntax"
                    end
                end
            } )
        end,

        build = ":TSUpdate",
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
            vim.opt.complete:remove { "i" }
            vim.opt.iskeyword:append { ":" }

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
                    { name = 'vsnip' },
                    { name = 'calc' },
                } )
            } )
        end
    },

    -- "depends": "DeXP/xkb-switch-win"
    -- { "lyokha/vim-xkbswitch" },
    -- { "DeXP/xkb-switch-win" },
}
