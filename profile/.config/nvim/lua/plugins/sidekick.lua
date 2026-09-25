local DEFAULT_TOOL = "copilot"

return {
    {
        "folke/sidekick.nvim",
        -- enabled = false,
        lazy = false,
        keys = {
            -- {
            --     "<tab>",
            --     function ()
            --         if not require( "sidekick" ).nes_jump_or_apply() then
            --             return "<Tab>"
            --         end
            --     end,
            --     expr = true,
            --     desc = "Goto/Apply Next Edit Suggestion",
            -- },
            {
                "<leader>aa",
                function ()
                    require( "sidekick.cli" ).show( {
                        name = DEFAULT_TOOL,
                        focus = true,
                    } )
                end,
                mode = { "n", "i", "v" },
                desc = "Sidekick Show / Focus on CLI",
            },
            {
                "<leader>aq",
                function ()
                    require( "sidekick.cli" ).toggle( {
                        name = DEFAULT_TOOL,
                        focus = true,
                    } )
                end,
                mode = { "n", "i", "v" },
                desc = "Sidekick Toggle CLI",
            },
            {
                "<leader>as",
                function () require( "sidekick.cli" ).select( { filter = { installed = true } } ) end,
                mode = { "n", "i", "v" },
                desc = "Select CLI",
            },
            {
                "<leader>ad",
                function () require( "sidekick.cli" ).close() end,
                mode = { "n", "i", "v" },
                desc = "Detach a CLI Session",
            },
            {
                "<leader>at",
                function () require( "sidekick.cli" ).send( { msg = "{this}" } ) end,
                mode = { "n", "i", "v" },
                desc = "Send This",
            },
            {
                "<leader>af",
                function () require( "sidekick.cli" ).send( { msg = "{file}" } ) end,
                mode = { "n", "i", "v" },
                desc = "Send File",
            },
            {
                "<leader>av",
                function () require( "sidekick.cli" ).send( { msg = "{selection}" } ) end,
                mode = { "x" },
                desc = "Send Visual Selection",
            },
            {
                "<leader>ap",
                function ()
                    require( "sidekick.cli" ).prompt( {
                        cb = function ( msg )
                            if msg then
                                require( "sidekick.cli" ).send( {
                                    msg = msg,
                                    name = DEFAULT_TOOL,
                                } )
                            end
                        end,
                    } )
                end,
                mode = { "n", "i", "v" },
                desc = "Sidekick Select Prompt",
            },
        },
        config = function ()
            local prompts
            local prompts_path = vim.fn.stdpath( "config" ) .. "/prompts.yaml"

            local file = io.open( prompts_path, "r" )
            if file then
                local yaml = require( "tinyyaml" )

                local content = file:read( "*all" )
                file:close()

                local success, data = pcall( yaml.parse, content )
                if success and type( data ) == "table" then
                    prompts = data
                end
            end

            require( "sidekick" ).setup( {
                cli = {
                    prompts = prompts,
                    picker = "telescope",
                    mux = {
                        enabled = false,
                        backend = "tmux",
                    },
                },
                nes = {
                    enabled = true,
                },
            } )
        end,
    },
}
