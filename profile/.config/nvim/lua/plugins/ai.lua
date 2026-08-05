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
        -- DOCS: https://codecompanion.olimorris.dev/
        "olimorris/codecompanion.nvim",
        -- enabled = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        cmd = { "CodeCompanion", "CodeCompanionChat", "CodeCompanionActions" },
        config = function ()
            require( "codecompanion" ).setup( {
                interactions1 = {
                    chat = {
                        adapter = {
                            name = "copilot",
                            -- model = "auto",
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
                    log_level = "DEBUG", -- or "TRACE"
                },
            } )
        end,
    },
    {
        "github/copilot.vim",
        enabled = false,
    },
    {
        "copilotc-nvim/copilotchat.nvim",
        enabled = false,
        dependencies = {
            {
                "nvim-lua/plenary.nvim",
            },
        },
        -- build = "make tiktoken",
        opts = {
            -- model = "Claude Sonnet 5"
        },
    },
}
