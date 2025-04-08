local function progress ()
    local cur = vim.fn.line( "." )
    local total = vim.fn.line( "$" )

    if cur == 1 then
        return "1%%"
    elseif cur == total then
        return "100%%"
    else
        return string.format( "%2d%%%%", math.floor( cur / total * 100 ) )
    end
end

return progress
