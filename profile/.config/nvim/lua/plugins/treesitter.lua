return {
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = {
            "foalford/vim-markdown-folding"
        },

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
}
