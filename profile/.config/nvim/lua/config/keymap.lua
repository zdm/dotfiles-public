-- open tab
vim.keymap.set( { "n", "i", "v" }, "<C-t>", "<CMD>:tabnew<CR>", {
    desc = "Open new tab",
} )

-- close tab
vim.keymap.set( { "n", "i", "v" }, "<C-w><C-w>", "<CMD>:tabclose<CR>", {
    desc = "Close tab",
} )

-- switch tabs
vim.keymap.set( { "n", "i", "v" }, "<C-PageUp>", "<CMD>:tabprevious<CR>", {
    desc = "Previous tab",
} )
vim.keymap.set( { "n", "i", "v" }, "<C-S-TAB>", "<CMD>:tabprevious<CR>", {
    desc = "Previous tab",
} )

vim.keymap.set( { "n", "i", "v" }, "<C-PageDown>", "<CMD>:tabnext<CR>", {
    desc = "Next tab",
} )
vim.keymap.set( { "n", "i", "v" }, "<C-TAB>", "<CMD>:tabnext<CR>", {
    desc = "Next tab",
} )

-- move tab left
-- XXX not work
vim.keymap.set( { "n", "i", "v" }, "<C-S-PageUp>", "<CMD>:-tabm<CR>", {
    desc = "Move tab left",
} )

-- move tab right
-- XXX not work
vim.keymap.set( { "n", "i", "v" }, "<C-S-PageDown>", "<CMD>:+tabm<CR>", {
    desc = "Move tab right",
} )

-- highlight word under cursor
vim.keymap.set( { "n" }, "*", "*N", {
    desc = "Highlight word under cursor",
} )

vim.keymap.set( { "n" }, "<Space>", "<CMD>:noh<CR>", {
    desc = "Cleanup search highlight",
} )

vim.keymap.set( { "n" }, "<CR>", "a", {
    desc = "Switch to INSERT mode",
} )

-- indent / unindent lines
-- vim.keymap.set( { "n" }, "<TAB>", "I<TAB><ESC>", {
--     desc = "Indent line under cursor",
-- } )

-- vim.keymap.set( { "n" }, "<S-TAB>", "^i<BS><ESC>", {
--     desc = "Unindent line under cursor",
-- } )

vim.keymap.set( { "s" }, "<TAB>", "<C-g>>gv<C-g>", {
    desc = "Indent line under cursor",
} )

vim.keymap.set( { "s" }, "<S-TAB>", "<C-g><gv<C-g>", {
    desc = "Unindent line under cursor",
} )

vim.keymap.set( { "x" }, "<TAB>", ">gv", {
    desc = "Indent selected lines",
} )

vim.keymap.set( { "x" }, "<S-TAB>", "<gv", {
    desc = "Unindent selected lines",
} )

-- XXX
-- move tabs with <C-S-J>, <C-S-K> {{{
-- vim.keymap.set( "n", "<C-S-J>", "<Cmd>-tabm<CR>", { silent = true } )
-- vim.keymap.set( "i", "<C-S-J>", "<ESC><Cmd>-tabm<CR>a", { silent = true } )
-- vim.keymap.set( "v", "<C-S-J>", "<ESC><Cmd>-tabm<CR>gv", { silent = true } )

-- vim.keymap.set( "n", "<C-S-K>", "<Cmd>+tabm<CR>", { silent = true } )
-- vim.keymap.set( "i", "<C-S-K>", "<ESC><Cmd>+tabm<CR>a", { silent = true } )
-- vim.keymap.set( "v", "<C-S-K>", "<ESC><Cmd>+tabm<CR>gv", { silent = true } )
-- }}}

-- XXX
-- <C-W><C-ARROW> - move windows (not work in console) {{{
-- vim.keymap.set( "n", "<C-W><C-Left>", "<C-W>H" )
-- vim.keymap.set( "n", "<C-W><C-Right>", "<C-W>L" )
-- vim.keymap.set( "n", "<C-W><C-Up>", "<C-W>K" )
-- vim.keymap.set( "n", "<C-W><C-Down>", "<C-W>J" )
-- }}}

-- XXX not work
-- open current buffer in the new tab
-- vim.keymap.set( "n", "<c-w><c-t>", "<C-W>T" )

-- remap Up and Down to move inside visible lines {{{
vim.keymap.set( "n", "<Up>", function ()
    return vim.v.count ~= 0 and "k" or "gk"
end, { expr = true } )

vim.keymap.set( "n", "<Down>", function ()
    return vim.v.count ~= 0 and "j" or "gj"
end, { expr = true } )

-- vim.keymap.set( "n", "<S-Up>", "gh<C-o>gk" )
-- vim.keymap.set( "n", "<S-Down>", "gh<C-o>gj" )

-- XXX produces garbage
-- vim.keymap.set( "i", "<Up>", "<C-o>gk" )
-- vim.keymap.set( "i", "<Down>", "<C-o>gj" )

-- vim.keymap.set( "i", "<S-Up>", "<C-o>gh<C-o>gk" )
-- vim.keymap.set( "i", "<S-Down>", "<C-o>gh<C-o>gj" )

-- vim.keymap.set( "x", "<Up>", "gk" )
-- vim.keymap.set( "x", "<Down>", "gj" )
-- vim.keymap.set( "x", "<S-Up>", "k" )
-- vim.keymap.set( "x", "<S-Down>", "j" )
-- vim.keymap.set( "x", "<Left>", "h" )
-- vim.keymap.set( "x", "<Right>", "l" )
-- vim.keymap.set( "s", "<S-Up>", "<C-o>gk" )
-- vim.keymap.set( "s", "<S-Down>", "<C-o>gj" )
-- }}}
