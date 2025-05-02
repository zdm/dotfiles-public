return {
    {
        "sindrets/diffview.nvim",
        dev = true,
        config = function ()
            local diffview = require( "diffview" )

            diffview.setup( {
                git_cmd = { vim.fn.has( "win32" ) == 1 and "git.exe" or "git" },
                use_icons = false,
                view = {
                    merge_tool = {
                        layout = "diff3_mixed", -- "diff1_plain"
                        disable_diagnostics = true,
                        winbar_info = true,
                    },
                },
                file_panel = {
                    listing_style = "list", -- "tree"
                    tree_options = {
                        flatten_dirs = true,
                        folder_statuses = "only_folded",  -- "never", "only_folded", "always"
                    },
                    win_config = {
                        position = "left",
                        width = 30,
                        win_opts = {},
                    },
                },
            } )

            -- open file history for current file
            vim.keymap.set( { "n", "i" }, "<Leader>gh", function ()
                diffview.file_history( nil, { "%" } )
            end, {
                buffer = bufnr
            } )
        end
    },
}
