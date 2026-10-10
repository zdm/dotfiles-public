local M = {}

local CURSOR_MARKER = '^%s*"%s*cursor:'

local function find_template ( name )
    return vim.api.nvim_get_runtime_file( "templates/" .. name, false )[ 1 ]
end

local function apply_cursor_marker ()
    local last = vim.fn.getline( "$" )

    if not last:find( CURSOR_MARKER ) then
        return
    end

    local y = tonumber( last:match( CURSOR_MARKER .. "%s*(%d+)" ) ) or 0
    local x = tonumber( last:match( CURSOR_MARKER .. "%s*%d+%s+(%d+)" ) ) or 0

    vim.cmd( "silent! $foldopen!" )
    vim.cmd( "silent $delete _" )
    vim.fn.cursor( y, x )
end

local function load_template ( filetype, fext )
    if fext == "" then
        return
    end

    local file = find_template( fext )

    if file == nil and filetype ~= "" then
        file = find_template( filetype )
    end

    if file == nil then
        return
    end

    vim.cmd( "silent keepalt 1read " .. vim.fn.fnameescape( file ) )
    vim.cmd( "silent 1delete _" )

    apply_cursor_marker()

    vim.bo.modified = false
end

function M.setup ()
    local group = vim.api.nvim_create_augroup( "template", { clear = true } )

    vim.api.nvim_create_autocmd( "FileType", {
        group = group,
        pattern = "*",
        callback = function ( args )
            if vim.fn.line2byte( vim.fn.line( "$" ) + 1 ) == -1 then
                load_template( args.match, vim.fn.fnamemodify( args.file, ":e" ) )
            end
        end,
    } )

    vim.api.nvim_create_user_command( "New", function ( opts )
        vim.cmd.new()
        vim.bo.filetype = opts.args
    end, { nargs = 1 } )
end

M.setup()

return M
