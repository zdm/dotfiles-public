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
                    disable = function( lang, buf )
                        local max_filesize = 100 * 1024
                        local ok, stats = pcall( vim.loop.fs_stat, vim.api.nvim_buf_get_name( buf ) )

                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,
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

            -- XXX not works when text is pasted
            local updateFolds = function ( force )
                if not force then
                    if vim.wo.foldmethod ~= "expr" then
                        return
                    end
                end

                vim.wo.foldmethod = "manual"

                if require( "nvim-treesitter.parsers" ).has_parser() then
                    vim.bo.syntax = "off"

                    if vim.bo.filetype == "markdown" then
                        vim.wo.foldexpr = "StackedMarkdownFolds()"
                    else
                        vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
                    end

                    vim.wo.foldmethod = "expr"
                else
                    vim.bo.syntax = "on"
                    vim.wo.foldmethod = "syntax"
                end

                -- open fold under the cursor
                vim.cmd.normal( "zv" )

                vim.b.folds_update_pending = false
            end

            vim.api.nvim_create_autocmd( "FileType", {
                group = gid,
                callback = function ( ev )
                    if require( "utils" ).hasTreesitter( ev.buf ) then
                        require( "utils" ).parseTreesitter( ev.buf, true )
                    end

                    updateFolds( true )
                end
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

            vim.api.nvim_create_autocmd( "TextChangedI", {
                group = gid,
                callback = function ()
                    vim.b.folds_update_pending = true
                end
            } )

            -- XXX produces enexpected garbage
            -- vim.api.nvim_create_autocmd( "TextChanged", {
            --     group = gid,
            --     callback = function ()
            --         vim.b.folds_update_pending = true

            --         updateFolds()
            --     end
            -- } )
        end,

        build = ":TSUpdate",
    },
}
