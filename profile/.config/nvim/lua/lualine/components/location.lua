local function location ()
    local total_lines = vim.fn.line( "$" )
    local line = vim.fn.line( "." )
    local column = vim.fn.charcol( "." )

    return string.format( "ln: %d/%d  cn:%d", total_lines, line, column )
end

return location
