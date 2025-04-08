local function progress ()
    local total_lines = vim.fn.line( "$" )
    local line = vim.fn.line( "." )

vim.print( "--- progress" )

    if line == 1 then
        return "1%%";
    else
        return string.format( "%2d%%%%", math.floor( line / total_lines * 100 ) )
    end
end

return progress
