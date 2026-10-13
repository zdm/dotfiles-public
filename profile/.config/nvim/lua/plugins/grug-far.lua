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
        config = function ()
            local grug = require( "grug-far" )

            local options = {
                windowCreationCommand = "tabnew",
                prefills = {
                    flags = "--context=1 --multiline",
                    filesFilter = "!**/node_modules/**\n!**/.git/**",
                },
                -- engines = {
                --     ripgrep = {
                --         extraArgs = "--glob=!**/node_modules/** --glob=!**/.git/**",
                --     },
                -- },
            }

            grug.setup( options )

            local open = grug.open;

            grug.open = function ( options )
                options = vim.deepcopy( options or {} );

                options.prefills = vim.tbl_extend( "keep", options.prefills or {}, {
                    paths = current_dir(),
                } );

                return open( options );
            end

            vim.api.nvim_create_user_command( "GrugFar", function ()
                grug.open();
            end, {} );
        end
    },
}
