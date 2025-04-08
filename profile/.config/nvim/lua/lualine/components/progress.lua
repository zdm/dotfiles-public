local function progress ()
    local total_lines = vim.fn.line( "$" )
    local line = vim.fn.line( "." )

    if line == 1 then
        return "  1%%"
    elseif line == total_lines then
        return "100%%"
    else
        return string.format( " %2d%%%%", math.floor( line / total_lines * 100 ) )
    end
end

return progress
