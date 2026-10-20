return {
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = false,
        dependencies = {
            "zcli.nvim",
        },
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
                "gitcommit",
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

            -- applies treesitter folds to the window that shows `buf` (not to the current window).
            -- Options are set locally (`[ 0 ]`), so global defaults stay untouched; when treesitter
            -- is not used for the buffer, the window gets the global defaults back.
            local function apply_folds ( buf, enabled )
                local win = vim.fn.bufwinid( buf )

                -- buffer is not displayed (e.g. `bufdo`), it will be handled in BufWinEnter
                if win == -1 then
                    return
                end

                local wo = vim.wo[ win ][ 0 ]

                if enabled then
                    wo.foldmethod = "expr"
                    wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
                else
                    wo.foldmethod = vim.go.foldmethod
                    wo.foldexpr = vim.go.foldexpr
                end
            end

            local gid = vim.api.nvim_create_augroup( "folds-updater", {} )

            vim.api.nvim_create_autocmd( "FileType", {
                group = gid,
                callback = function ( ev )
                    -- skip service buffers (blink.cmp menu/docs, floating windows, terminals, etc.)
                    if vim.bo[ ev.buf ].buftype ~= "" or vim.startswith( ev.match, "blink-cmp" ) then
                        return
                    end

                    local treesitter = require( "nvim-treesitter" )
                    local language = vim.treesitter.language.get_lang( ev.match )
                    local enabled = false

                    -- `get_lang` returns nil for filetypes without a known parser
                    if language and vim.list_contains( treesitter.get_available(), language ) then
                        if not vim.list_contains( treesitter.get_installed(), language ) then
                            treesitter.install( language ):wait()
                        end

                        -- `start` throws if the parser failed to install/load (no compiler, no network, etc.)
                        enabled = pcall( vim.treesitter.start, ev.buf )
                    else
                        vim.treesitter.stop( ev.buf )
                    end

                    if enabled then
                        vim.bo[ ev.buf ].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                    else
                        vim.bo[ ev.buf ].syntax = "on"
                    end

                    vim.b[ ev.buf ].treesitter_folds = enabled

                    apply_folds( ev.buf, enabled )

                    -- update folds
                    vim.schedule( function ()
                        require( "zcli/utils" ).update_folds( ev.buf )
                    end )
                end
            } )

            -- fold options are window-local: re-apply them whenever the buffer is shown in a window
            vim.api.nvim_create_autocmd( "BufWinEnter", {
                group = gid,
                callback = function ( ev )
                    local enabled = vim.b[ ev.buf ].treesitter_folds

                    if enabled ~= nil then
                        apply_folds( ev.buf, enabled )
                    end
                end
            } )
        end,
    },
}
