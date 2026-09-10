return {
    {
        "saghen/blink.cmp",
        version = "*",
        dependencies = {
            "saghen/blink.lib",
            "saghen/blink.compat",
            "allaman/emoji.nvim",
            "hrsh7th/cmp-calc",
            "l3mon4d3/luasnip",
            "fang2hou/blink-copilot",

            -- XXX
            "https://codeberg.org/FelipeLema/bink-cmp-vsnip.git",
            {
                -- "hrsh7th/vim-vsnip",
                "neovim-plugins/vim-vsnip",
                dev = true,
                init = function ()
                    vim.g.vsnip_snippet_dir = vim.fn.stdpath( "config" ) .. "/vsnip"

                    vim.g.vsnip_filetypes = {
                        [ "bash" ] = { "sh" },
                        [ "html/javascript" ] = { "javascript", "html/javascript" },
                        [ "vue" ] = { "html", "vue/html" },
                        [ "vue/javascript" ] = { "javascript", "html/javascript", "vue/javascript" },
                    }
                end
            },

            -- optional: provides snippets for the snippet source
            -- "rafamadriz/friendly-snippets",
        },
        build = function()
            require( "blink.cmp" ).build():pwait()
        end,
        opts = {
            keymap = {
                preset = "none",
                [ "<C-Up>" ] = { "select_prev", "fallback" },
                [ "<C-Down>" ] = { "show", "select_next", "fallback" },
                [ "<CR>" ] = { "accept", "fallback" },
            },
            completion = {
                documentation = {
                    auto_show = true,
                },
                list = {
                    selection = {
                        preselect = false,
                        auto_insert = false,
                    },
                },
            },
            snippets = {
                -- XXX
                preset = "luasnip",
                -- preset = "vsnip"
            },
            sources = {
                default = {
                    "snippets",
                    "emoji",
                    "calc",
                    "codecompanion",
                    "copilot",
                    "lsp",

                    -- "buffer",
                    -- "path",
                },
                providers = {
                    snippets = {
                        min_keyword_length = 1,
                        -- should_show_items = function(ctx)

                        --     -- Hide snippets when the menu is triggered by an empty or non-matching context
                        --     return ctx.trigger.initial_kind ~= "trigger_character"
                        -- end,
                    },
                    emoji = {
                        name = "emoji",
                        module = "blink.compat.source",
                        transform_items = function ( ctx, items )
                            local kind = require( "blink.cmp.types" ).CompletionItemKind.Text

                            for i = 1, #items do
                                items[i].kind = kind
                            end

                            return items
                        end,
                    },
                    calc = {
                        name = "calc",
                        module = "blink.compat.source",
                    },
                    codecompanion = {
                        name = "CodeCompanion",
                        module = "codecompanion.providers.completion.blink",
                        enabled = true,
                    },
                    copilot = {
                        name = "copilot",
                        module = "blink-copilot",
                        score_offset = 100,
                        async = true,
                    },
                },
            },
            fuzzy = {
                implementation = "rust",
                max_typos = 0,
                frecency = {
                    enabled = true,
                },
                use_proximity = true,
            },
            signature = {
                enabled = true
            },
            cmdline = {
                enabled = true,
                keymap = {
                    preset = "inherit",
                },
                completion = {
                    menu = {
                        auto_show = true,
                    },
                },
            },
        },
    },
}
