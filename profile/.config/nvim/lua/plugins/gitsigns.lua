local diff_signs = {
    add          = { text = "+", show_count = true },
    change       = { text = "~", show_count = true },
    delete       = { text = "-", show_count = true },
    topdelete    = { text = "-", show_count = true },
    changedelete = { text = "~", show_count = true },
    untracked    = { text = "?", show_count = true },
}

return {
    {
        -- "lewis6991/gitsigns.nvim",
        "zdm/gitsigns.nvim",
        dev = true,
        dependencies = {
            "telescope.nvim",
        },
        config = function ()
            local gitsigns = require( "gitsigns" )

            gitsigns.setup( {
                git_cmd = vim.fn.has( "win32" ) == 1 and "git.exe" or "git",
                signs = diff_signs,
                signs_staged = diff_signs,
                signs_staged_enable = true,
                signcolumn = true,
                numhl      = false,
                linehl     = false,
                word_diff  = false,
                watch_gitdir = {
                    follow_files = true
                },
                auto_attach = true,
                attach_to_untracked = false,
                current_line_blame = false,
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = "eol", -- "eol", "overlay", "right_align"
                    delay = 1000,
                    ignore_whitespace = false,
                    virt_text_priority = 100,
                    use_focus = true,
                },
                current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
                sign_priority = 6,
                update_debounce = 100,
                status_formatter = nil, -- Use default
                max_file_length = 40000, -- Disable if file is longer than this (in lines)
                preview_config = {
                    border = "single",
                    style = "minimal",
                    relative = "cursor",
                    row = 0,
                    col = 1
                },

                debug_mode = false,

                on_attach = function ( bufnr )

                    -- previous hunk
                    vim.keymap.set( "n", "[c", function ()
                            gitsigns.nav_hunk( "prev", {
                                wrap = false,
                                navigation_message = true,
                                foldopen = true,
                                preview = false,
                                greedy = false,
                                target = "all",
                            } )
                        end, {
                            buffer = bufnr
                        }
                    )

                    -- next hunk
                    vim.keymap.set( "n", "]c", function ()
                            gitsigns.nav_hunk( "next", {
                                wrap = false,
                                navigation_message = true,
                                foldopen = true,
                                preview = false,
                                greedy = false,
                                target = "all",
                            } )
                        end, {
                            buffer = bufnr
                        }
                    )

                    -- preview hunk
                    vim.keymap.set( { "n", "i" }, "<Leader>gg", function ()
                            gitsigns.preview_hunk()
                        end, {
                            buffer = bufnr
                        }
                    )

                    -- show hunks list
                    vim.keymap.set( { "n", "i" }, "<Leader>gx", function ()
                            gitsigns.setqflist( bufnr, {
                                use_location_list = true,
                                open = false,
                            } )

                            -- XXX schedule

                            vim.cmd( "Telescope loclist theme=ivy layout_config={width=0.99}" )

                        end, {
                            buffer = bufnr
                        }
                    )

                    -- select hunk
                    vim.keymap.set( { "n", "i" }, "<Leader>gs", function ()
                            gitsigns.select_hunk()
                        end, {
                            buffer = bufnr
                        }
                    )

                    -- stage / unstage hunk
                    vim.keymap.set( { "n", "i" }, "<Leader>ga", function ()
                            gitsigns.stage_hunk()
                        end, {
                            buffer = bufnr
                        }
                    )

                    -- reset hunk
                    vim.keymap.set( { "n", "i" }, "<Leader>gr", function ()
                            gitsigns.reset_hunk()
                        end, {
                            buffer = bufnr
                        }
                    )

                    -- diff buffer
                    vim.keymap.set( { "n", "i" }, "<Leader>gd", function ()
                            vim.cmd.tabnew( "%" )

                            gitsigns.diffthis( nil, {
                                vertical = true,
                            } )
                        end, {
                            buffer = bufnr
                        }
                    )

                    -- blame buffer
                    vim.keymap.set( { "n", "i" }, "<Leader>gb", function ()
                            gitsigns.blame()
                        end, {
                            buffer = bufnr
                        }
                    )
                end
            } )
        end,
    }
}
