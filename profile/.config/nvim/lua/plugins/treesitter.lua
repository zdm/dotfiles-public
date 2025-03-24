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

            local gid = vim.api.nvim_create_augroup( "folds-updater", {} )

            local updateFolds = function ()
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

                -- open fold under the cursor
                vim.cmd.normal( "zv" )

                vim.b.folds_update_pending = false
            end

            vim.api.nvim_create_autocmd( { "FileType" }, {
                group = gid,
                callback = updateFolds
            } )

            vim.api.nvim_create_autocmd( "ModeChanged", {
                group = gid,
                pattern = "*:n",
                callback = function( ev )
                    if vim.b.folds_update_pending then
                        updateFolds()
                    end
                end
            } )

            -- XXX update calles too fast
            vim.api.nvim_create_autocmd( { "TextChanged", "TextChangedI" }, {
                group = gid,
                callback = function ()
                    vim.b.folds_update_pending = true

                    if vim.api.nvim_get_mode().mode == "n" then
                        updateFolds()
                    end
                end
            } )
        end,

        build = ":TSUpdate",
    },
}
