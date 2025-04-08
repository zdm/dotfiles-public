local function progress ()
    local total_lines = vim.fn.line( "$" )
    local line = vim.fn.line( "." )

    return string.format( " %2d%%%%", math.floor( line / total_lines * 100 ) )
end

return progress
