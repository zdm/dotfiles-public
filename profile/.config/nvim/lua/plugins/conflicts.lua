return {
    {
        "rhysd/conflict-marker.vim",
        enabled = false,
        init = function ()
        end,
    },
    {
        "akinsho/git-conflict.nvim",
        version = "2.1.0",
        enabled = false,
        config = function ()
            require( "git-conflict" ).setup( {
                default_mappings = true,
                default_commands = true,
                disable_diagnostics = false,

                -- command or function to open the conflicts list
                list_opener = "copen",
                highlights = {
                    incoming = "DiffAdd",
                    current = "DiffText",
                }
            } )

            -- GitConflictResolved
            vim.api.nvim_create_autocmd( "User", {
                pattern = "GitConflictDetected",
                callback = function ( args )
                    vim.notify( "Conflict detected in " .. vim.fn.expand( "<afile>" ) )

                    vim.keymap.set( "n", "cww",
                        function ()
                            engage.conflict_buster()

                            create_buffer_local_mappings()
                        end
                    )
                end
            } )
        end
    },
}
