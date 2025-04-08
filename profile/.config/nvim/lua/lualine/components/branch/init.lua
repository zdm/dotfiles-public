local M = require( "lualine.component" ):extend()
local modules = require( "lualine_require" ).lazy_require( {
    git_branch = "lualine.components.branch.git_branch",
    highlight = "lualine.highlight",
    utils = "lualine.utils.utils",
} )

M.init = function ( self, options )
    M.super.init( self, options )

    if not self.options.icon then
        self.options.icon = "⎇"
    end

    modules.git_branch.init()
end

M.update_status = function ( self, is_focused )
    local buf = ( not is_focused and vim.api.nvim_get_current_buf() )
    local branch = modules.git_branch.get_branch( buf )

    if branch and branch ~= "" then
        return self.options.icon .. " " .. modules.utils.stl_escape( branch )
    else
        return
    end
end

return M
