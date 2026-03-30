return {
    {
        "nvim-treesitter/nvim-treesitter",
        enbled = false,
        lazy = false,
        build = ":TSUpdate",
        config = function ()
            vim.env.CC = "gcc";

            require( "nvim-treesitter" ).setup( {
                install_dir = vim.fn.stdpath( "data" ) .. "/treesitter",
            } );

            require( "nvim-treesitter" ).install( {
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
                "php",
                "po",
                "pod",
                "powershell",
                "printf",
                "python",
                "query",
                "readline",
                "regex",
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
            } );

            local gid = vim.api.nvim_create_augroup( "folds-updater", {} )

            local updateFolds = function ( bufnr, force, no_unfold )
                if not bufnr then
                    bufnr = vim.api.nvim_get_current_buf()
                end

                local winid = vim.fn.bufwinid( bufnr )

                if not force then
                    if vim.wo[ winid ].foldmethod ~= "expr" then
                        return
                    end
                end

                vim.wo[ winid ].foldmethod = "manual"

                if require( "utils" ).has_treesitter( bufnr ) then
                    vim.bo[ bufnr ].syntax = "off"
                    vim.wo[ winid ].foldexpr = "v:lua.vim.treesitter.foldexpr()"
                    vim.wo[ winid ].foldmethod = "expr"
                else
                    vim.bo[ bufnr ].syntax = "on"
                    vim.wo[ winid ].foldmethod = "syntax"
                end

                -- open fold under the cursor
                if not no_unfold then
                    vim.cmd.normal( "zv" )
                end

                vim.b[ bufnr ].folds_update_pending = false
            end

            vim.api.nvim_create_autocmd( "FileType", {
                group = gid,
                callback = function ( ev )
                    if require( "utils" ).has_treesitter( ev.buf ) then
                        require( "utils" ).parse_treesitter( ev.buf, true )
                    end

                    updateFolds( ev.buf, true )
                end
            } )

            vim.api.nvim_create_autocmd( "ModeChanged", {
                group = gid,
                pattern = "*:n",
                callback = function( ev )
                    if vim.b[ ev.buf ].folds_update_pending then
                        updateFolds( ev.buf )
                    end
                end
            } )

            vim.api.nvim_create_autocmd( { "TextChanged", "TextChangedI" }, {
                group = gid,
                callback = function ( ev )
                    vim.b[ ev.buf ].folds_update_pending = true
                end
            } )

            local suffixes = { "a", "A" }

            for index, suffix in pairs( suffixes ) do
                vim.keymap.set( "n", "z" .. suffix, function ()
                        if vim.b.folds_update_pending then
                            updateFolds( nil, false, true )
                        end

                        return "z" .. suffix
                    end, {
                        expr = true,
                        noremap = true,
                        silent = true,
                    }
                )
            end
        end,
    },
}
