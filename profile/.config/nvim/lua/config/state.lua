-- shada
-- vim.opt.shada = {
--     "'50",
--     "<100",
--     "s100",
--     "!"
-- }

-- views
vim.o.viewdir = vim.fn.stdpath( "data" ) .. "/view"
-- vim.opt.viewoptions:append( { "cursor", "folds", "options" } )
vim.o.viewoptions = {
    "cursor",
    "folds",
    "options",
    "slash",
    "unix"
}

-- session
vim.o.sessionoptions = {
    "buffers",
    "curdir",
    "folds",
    "slash",
    "tabpages",
    "unix",
    "winsize"
}

local group = vim.api.nvim_create_augroup( 'AutoSaveView', {
    clear = true,
})

vim.api.nvim_create_autocmd( 'BufWinLeave', {
    group = group,
    callback = function ( ev )
        if vim.bo[ev.buf].buftype == "" then
            vim.cmd( "silent! mkview" )
        end
    end,
})

vim.api.nvim_create_autocmd( "BufWinEnter", {
    group = group,
    callback = function ( ev )
        if vim.bo[ ev.buf ].buftype == "" then
            vim.cmd( "silent! loadview" )
        end
    end,
} )
