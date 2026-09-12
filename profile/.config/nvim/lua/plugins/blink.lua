vim.api.nvim_create_autocmd( "ModeChanged", {
    pattern = "*:s",
    callback = function ()
        if vim.snippet.active() then
            vim.o.selection = "inclusive"
        end
    end,
})

vim.api.nvim_create_autocmd( "ModeChanged", {
    pattern = "s:*",
    callback = function ()
        vim.o.selection = "exclusive"
    end,
})

return {
    {
        "saghen/blink.cmp",
        version = "*",
        dependencies = {
            "saghen/blink.lib",
            "saghen/blink.compat",
            "allaman/emoji.nvim",
            "hrsh7th/cmp-calc",
            "fang2hou/blink-copilot",
            -- "rafamadriz/friendly-snippets",
        },
        build = function ()
            require( "blink.cmp" ).build():pwait()
        end,
        opts = {
            keymap = {
                preset = "none",
                [ "<C-Up>" ] = { "show", "select_prev", "fallback" },
                [ "<C-Down>" ] = { "show", "select_next", "fallback" },
                [ "<CR>" ] = { "accept", "fallback" },
                [ "<Tab>" ] = { "snippet_forward", "fallback" },
                [ "<S-Tab>" ] = { "snippet_backward", "fallback" },
            },
            completion = {
                documentation = {
                    auto_show = true,
                },
                ghost_text = {
                    enabled = true,
                },
                list = {
                    selection = {
                        preselect = false,
                        auto_insert = false,
                    },
                },
            },
            sources = {
                default = {
                    "snippets",
                    "yaml_snippets",
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
                    },
                    yaml_snippets = {
                        name = "yaml_snippets",
                        module = "yaml-snippets",
                    },
                    emoji = {
                        name = "emoji",
                        module = "blink.compat.source",
                        transform_items = function ( ctx, items )
                            local kind = require( "blink.cmp.types" ).CompletionItemKind.Text

                            for i = 1, #items do
                                items[ i ].kind = kind
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
                        enabled = function()
                            return vim.bo.filetype == "codecompanion"
                        end,
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
                enabled = true,
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
