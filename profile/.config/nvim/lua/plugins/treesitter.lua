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
            end

            vim.api.nvim_create_autocmd( { "FileType" }, {
                group = gid,
                callback = updateFolds
            } )

            vim.api.nvim_create_autocmd( "ModeChanged", {
                group = gid,
                pattern = "*:n",
                callback = function( ev )
                    -- local previousMode = ev.match:match( "(%a):" )
                    updateFolds()
                end
            } )

            -- vim.api.nvim_create_autocmd( { "BufWinEnter", "TextChanged", "BufWritePost" }, {
            --     group = gid,
            --     callback = updateFolds
            -- } )

            -- vim.api.nvim_create_autocmd( { "OptionSet" }, {
            --     group = gid,
            --     pattern = { "buftype", "filetype", "syntax", "diff" },
            --     callback = updateFolds
            -- } )
        end,

        build = ":TSUpdate",
    },
}
