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
            require( "grug-far" ).setup( {
                windowCreationCommand = "tabnew",
                prefills = {
                    flags = "--hidden --context=1 --multiline",
                    filesFilter = "!**/node_modules/**\n!**/.git/**",
                    paths = current_dir(),
                },
            } )
        end
    },
}
