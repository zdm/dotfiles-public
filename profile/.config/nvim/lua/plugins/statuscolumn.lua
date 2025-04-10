local signs = {
    close       = "▸",
    open        = "▾",
    sep         = "┋",
    last_next   = "├",
    last        = "└",
}

local folds = function ( options )
    local foldlevel = vim.fn.foldlevel( options.lnum )

    -- not a fold
    if foldlevel == 0 then
        return ""
    end

    local last_line = vim.fn.line( "$" )
    local foldlevel_before = vim.fn.foldlevel( ( options.lnum - 1 ) >= 1 and options.lnum - 1 or 1 )
    local foldlevel_after = options.lnum == last_line
        and -1
        or vim.fn.foldlevel(
            options.lnum + 1 <= last_line
            and options.lnum + 1
            or last_line
        )
    local foldclosed = vim.fn.foldclosed( options.lnum )

    -- close fold
    if foldclosed ~= -1 and foldclosed == options.lnum then
        return signs.close

    -- open fold
    elseif foldlevel > foldlevel_before or options.lnum == 1 then
        return signs.open

    -- end fold
    elseif foldlevel > foldlevel_after then
        if foldlevel_after == -1 then
            return signs.last
        elseif foldlevel_after == 0 then
            return signs.last
        else
            return signs.last_next
        end

    -- fold body
    else
        return signs.sep
    end
end

return {
    {
        "luukvbaal/statuscol.nvim",
        config = function ()
            local builtin = require( "statuscol.builtin" )

            require( "statuscol" ).setup( {
                segments = {
                    {
                        text = { folds },
                        click = "v:lua.ScFa"
                    },
                    {
                        sign = {
                            namespace = { "gitsigns" },
                            maxwidth = 1,
                            colwidth = 2,
                            auto = true,
                            wrap = true,
                        },
                        click = "v:lua.ScSa"
                    },
                    {
                        text = { " ", "%l", " " },
                        condition = {
                            builtin.not_empty,
                            true,
                            true,
                        },
                        click = "v:lua.ScLa",
                    },
                }
            } )
        end,
    }
}
