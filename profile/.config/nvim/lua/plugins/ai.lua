vim.api.nvim_create_user_command( "Ai", function ( opts )
    local range = ""

    if vim.api.nvim_get_mode().mode == "v" then
        range = "'<,'>"
    elseif opts.range > 0 then
        range = opts.line1 .. "," .. opts.line2
    else
        range = "%"
    end

    vim.cmd( string.format( "%sCodeCompanion %s", range, opts.args ) )
end, { nargs = "*", range = true } )

return {
    {
        "zbirenbaum/copilot.lua",
        -- enabled = false,
        dependencies = {
            {
                "copilotlsp-nvim/copilot-lsp",
            },
            {
                "zbirenbaum/copilot-cmp",
                config = function ()
                    require( "copilot_cmp" ).setup()
                end
            },
        },
        cmd = "Copilot",
        event = "InsertEnter",
        config = function ()
            require( "copilot" ).setup( {
                suggestion = {
                    enabled = true,
                    auto_trigger = true,
                    keymap = {
                        accept = false,
                        accept_line = "<Leader><TAB>",
                        accept_word = "<Leader><Leader><TAB>",
                        next = false,
                        prev = false,
                        dismiss = "<Leader>q",
                        toggle_auto_trigger = false,
                    },
                },
            } )
        end
    },
    {
        "olimorris/codecompanion.nvim",
        -- enabled = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionCLI", "CodeCompanionActions" },
        keys = {
            {
                "<Leader>aa",
                "<cmd>CodeCompanion<cr>",
                mode = { "n", "i" },
                desc = "[Ai] Execute CodeCompanion",
            },
            {
                "<Leader>aa",
                ":CodeCompanion<cr>",
                mode = { "v" },
                desc = "[Ai] Execute CodeCompanion",
            },
            {
                "<Leader>ac",
                "<cmd>CodeCompanionChat<cr>",
                mode = { "n", "i", "v" },
                desc = "[Ai] Execute CodeCompanionChat",
            },
            -- {
            --     "<Leader>a",
            --     mode = { "n", "i", "v" },
            --     desc = "[Ai] Execute CodeCompanion CLI with current buffer",
            --     function ()
            --         require( "codecompanion" ).cli( "#{this}", {
            --             focus = true,
            --             prompt = true,
            --         } )
            --     end,
            -- },
        },
        config = function ()
            require( "codecompanion" ).setup( {
                adapters = {
                    http = {
                        copilot = function ()
                            return require( "codecompanion.adapters" ).extend( "copilot", {
                                schema = {
                                    model = {
                                        default = "gpt-4o", -- "gpt-4o" for FREE plan
                                    },
                                },
                            } )
                        end,
                        ollama = function ()
                            return require( "codecompanion.adapters" ).extend( "ollama", {
                                env = {
                                    url = "http://devel:11434",
                                },
                                schema = {
                                    model = {
                                        default = "qwen2.5-coder:7b", -- change to your pulled model
                                    },
                                    num_ctx = {
                                        default = 16384, -- adjust context window size
                                    },
                                },
                            } )
                        end,
                    },
                },
                interactions = {
                    inline = {
                        adapter = "copilot",
                        keymaps = {
                            -- accept_change = {
                            --     modes = { n = "ga" },
                            --     description = "Accept the suggested change",
                            --     opts = { nowait = true },
                            -- },
                            -- reject_change = {
                            --     modes = { n = "gr" },
                            --     description = "Reject the suggested change",
                            --     opts = { nowait = true },
                            -- },
                        },
                    },
                    chat = {
                        adapter = "copilot",
                        keymaps = {
                            send = {
                                modes = {
                                    n = "<C-s>",
                                    i = "<C-s>"
                                },
                            },
                            close = false, -- Completely disable a default keymap
                        },
                        tools = {
                            [ "insert_edit_into_file" ] = {
                                callback = "strategies.chat.tools.insert_edit_into_file",
                                description = "Insert edits into a file",
                            },
                        },
                        opts = {
                            completion_provider = "cmp",
                        }
                    },
                    cli = {
                        agent = "copilot",
                        agents = {
                            copilot = {
                                cmd = "copilot",
                                args = {},
                                description = "Copilot CLI",
                                provider = "terminal",
                            },
                        },
                    },
                },
                opts = {
                    log_level = "DEBUG", -- "TRACE"
                },
            } )
        end,
    },
    {
        "copilotc-nvim/copilotchat.nvim",
        enabled = false,
        dependencies = {
            {
                "nvim-lua/plenary.nvim",
            },
        },
        config = function ()
            require( "copilotchat" ).setup( {
                model = "auto",
            } )
        end,
    },
    {
        -- NOTE: replaced with copilot.lua
        "github/copilot.vim",
        enabled = false,
    },
}
