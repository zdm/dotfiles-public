return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        build = ":TSUpdate",
        config = function ()
            vim.env.CC = "gcc"

            local install_dir = vim.fs.normalize( vim.fn.stdpath( "data" ) .. "/treesitter" )

            require( "nvim-treesitter" ).setup( {
                install_dir = install_dir,
            } );

            vim.opt.rtp:remove( install_dir )
            vim.opt.rtp:append( install_dir )

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

            vim.api.nvim_create_autocmd( "FileType", {
                group = gid,
                callback = function ( ev )
                    local treesitter = require( "nvim-treesitter" )
                    local language = vim.treesitter.language.get_lang( ev.match )

                    if vim.list_contains( treesitter.get_available(), language ) then
                        if not vim.list_contains( treesitter.get_installed(), language ) then
                            treesitter.install( language ):wait()
                        end

                        vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
                        vim.wo.foldmethod = "expr"
                        vim.bo[ ev.buf ].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

                        vim.treesitter.start( ev.buf )
                    else
                        vim.treesitter.stop( ev.buf )

                        vim.bo[ ev.buf ].syntax = "on"
                    end

                    -- update folds
                    require( "utils" ).update_folds( ev.buf, function ()
                        vim.cmd.normal( "zx" )
                    end )
                end
            } )

            vim.api.nvim_create_autocmd( { "TextChanged", "TextChangedI" }, {
                group = gid,
                callback = function ( ev )
                    vim.b[ ev.buf ].folds_update_pending = true
                end
            } )

            vim.api.nvim_create_autocmd( "ModeChanged", {
                group = gid,
                pattern = "*:n",
                callback = function( ev )
                    if vim.b[ ev.buf ].folds_update_pending then
                        vim.b[ ev.buf ].folds_update_pending = false

                        -- update folds
                        require( "utils" ).update_folds( ev.buf, function ()
                            -- vim.cmd.normal( "zM" )
                            vim.cmd.normal( "zv" )
                            -- vim.cmd.normal( "zx" )
                        end )
                    end
                end
            } )
        end,
    },
}
