local function location ()
    local total_lines = vim.fn.line( "$" )
    local line = vim.fn.line( "." )
    local column = vim.fn.charcol( "." )

    return string.format( "line: %d/%d  col: %d", line, total_lines, column )
end

return location
