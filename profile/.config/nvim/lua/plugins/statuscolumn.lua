local folds = function ( options )
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

    -- close fold
    if foldclosed ~= -1 and foldclosed == options.lnum then
        return options.fold.close

    -- open fold
    elseif foldlevel > foldlevel_before or options.lnum == 1 then
        return options.fold.open

    -- end fold
    elseif foldlevel > foldlevel_after then
        if foldlevel_after == -1 then
            return "└"

        -- XXX
        elseif foldlevel > foldlevel_after then
            return "├" -- "└"
        else
            return "├"
            -- return "╰"
        end

    -- fold body
    else
        return "┋"
        -- return options.fold.sep
        -- return "╎"
    end
end

return {
    {
        "luukvbaal/statuscol.nvim",
        -- enabled = false,
        config = function ()
            local builtin = require( "statuscol.builtin" )

            require( "statuscol" ).setup( {
                segments = {
                    {
                        text = {
                            folds,
                            -- builtin.foldfunc
                        },
                        click = "v:lua.ScFa"
                    },
                    {
                        sign = {
                            name = { ".*" },
                            text = { ".*" },
                            namespace = { ".*" },
                            maxwidth = 1,
                            colwidth = 2,
                            auto = true,
                            wrap = true,
                        },
                        click = "v:lua.ScSa"
                    },
                    {
                        text = { " ", "%l", " " },
                        click = "v:lua.ScLa",
                    },
                }
            } )
        end,
    }
}
