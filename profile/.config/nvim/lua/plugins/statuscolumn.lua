local foldColumnEnabled = true
local signs = {
    close       = "▸",
    open        = "▾",
    sep         = "┋",
    last_next   = "├",
    last        = "└",
}

local function foldcolumn ( options )
    local foldlevel = vim.fn.foldlevel( options.lnum )

    -- not a fold
    if foldlevel == 0 then
        return " "
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

    -- line inside closed fold
    if foldclosed ~= -1  then

        -- first line of the closed fold
        if foldclosed == options.lnum then
            return signs.close
        else
            return ""
        end

    -- fold open
    -- XXX no way to detect opened fold start line if foldlevel is not changed between lines
    -- XXX or ( foldlevel == foldlevel_before and ... )
    elseif options.lnum == 1 or foldlevel > foldlevel_before then
        return signs.open

    -- fold end
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
            local segments = {
                {
                    sign = {
                        namespace = { "softvisio" },
                        maxwidth = 1,
                        colwidth = 1,
                        auto = true,
                        foldclosed = true,
                    },
                    click = "v:lua.ScSa"
                },
                {
                    sign = {
                        namespace = { "gitsigns" },
                        maxwidth = 1,
                        colwidth = 2,
                        auto = true,
                        wrap = true,
                        foldclosed = true,
                    },
                    click = "v:lua.ScSa"
                },
                {
                    text = { " ", "%l", " " },
                    condition = { builtin.not_empty, true, true },
                    click = "v:lua.ScLa",
                },
            }

            -- add fold column
            if foldColumnEnabled then
                table.insert( segments, 1, {
                    text = { foldcolumn },
                    click = "v:lua.ScFa"
                } )
            end

            require( "statuscol" ).setup( {
                segments = segments,
            } )
        end,
    }
}
