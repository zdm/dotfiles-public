local ignored_filetypes

local M = {}

M.ignored_filetypes = {
    "blink-cmp",
    "DiffviewFileHistory",
    "DiffviewFiles",
    "gitgraph",
    "grug-far",
    "help",
    "man",
    "TelescopePrompt",
}

M.is_filetype_ignored = function ( filetype )
    if ignored_filetypes == nil then
        ignored_filetypes = {}

        for _, value in pairs( M.ignored_filetypes ) do
            ignored_filetypes[ value ] = true
        end
    end

    return ignored_filetypes[ filetype ]
end

return M
