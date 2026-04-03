local M = {}
local ignored_filetypes

M.ignored_filetypes = {
    "DiffviewFileHistory",
    "DiffviewFiles",
    "gitgraph",
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
