return {
    {
        "sindrets/diffview.nvim",
        dev = true,
        cmd = { "DiffviewOpen", "DiffviewFileHistory", "DiffviewClose" },
        keys = {
            {
                "<Leader>gv",
                "<CMD>DiffviewOpen<CR>",
                mode = { "n", "i", "v", "s" },
                desc = "OPen diff view",
            },
            {
                "<Leader>gh",
                "<CMD>DiffviewFileHistory --follow %<CR>",
                mode = { "n", "i", "v", "s" },
                desc = "Open file history",
            },
        },
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
                    listing_style = "tree", -- "list",
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
                file_history_panel = {
                    -- log_options = {
                    --     git = {
                    --         single_file = {
                    --             diff_merges = "combined",
                    --         },
                    --         multi_file = {
                    --             diff_merges = "first-parent",
                    --         },
                    --     },
                    -- },
                    win_config = {
                        position = "bottom",
                        height = 10,
                        win_opts = {},
                    },
                },
            } )
        end
    },
}
