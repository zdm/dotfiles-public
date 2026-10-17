local DEFAULT_FLAGS = "--hidden --context=1 --multiline";

local function current_dir ()
    local buf_name = vim.api.nvim_buf_get_name( 0 )

    local dir = vim.uv.cwd()

    if buf_name ~= "" and vim.bo.buftype == "" then
        dir = vim.fn.expand( "%:p:h" );
    end

    return ( dir:gsub( "\\", "/" ) );
end

return {
    {
        'MagicDuck/grug-far.nvim',
        cmd = "GrugFar",
        init = function ()
            vim.api.nvim_create_user_command( "Grep", function ( opts )
                local prefills = {
                    paths = current_dir(),
                };

                if opts.range > 0 then
                    local lines = vim.api.nvim_buf_get_lines( 0, opts.line1 - 1, opts.line2, false );

                    prefills.search = table.concat( lines, "\n" );
                    prefills.flags = DEFAULT_FLAGS .. " --fixed-strings";
                end

                require( "grug-far" ).open( {
                    prefills = prefills,
                } )
            end, { range = true } )
        end,
        config = function ()
            require( "grug-far" ).setup( {
                windowCreationCommand = "tabnew",
                prefills = {
                    flags = DEFAULT_FLAGS,
                    filesFilter = "!**/.git/**\n!**/node_modules/**",
                    paths = current_dir(),
                },
                openTargetWindow  = {
                    preferredLocation  = "right",
                },
            } )
        end
    },
}
