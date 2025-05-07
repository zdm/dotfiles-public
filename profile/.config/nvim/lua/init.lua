-- open tab
vim.keymap.set( { "n", "i", "v" }, "<C-t>", "<CMD>:tabnew<CR>", {
    desc = "Open new tab",
} )

-- close tab
vim.keymap.set( { "n", "i", "v" }, "<C-w>", "<CMD>:tabclose<CR>", {
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

-- move tabs
vim.keymap.set( { "n", "i", "v" }, "<C-S-PageUp>", "<CMD>:-tabm<CR>", {
    desc = "Move tab left",
} )

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

-- indent / unindent
vim.keymap.set( { "n" }, "<TAB>", "I<TAB><ESC>", {
    desc = "Indent line under cursor",
} )

vim.keymap.set( { "n" }, "<S-TAB>", "^i<BS><ESC>", {
    desc = "Unindent line under cursor",
} )

vim.keymap.set( { "v" }, "<TAB>", ">gv", {
    desc = "Indent selected lines",
} )

vim.keymap.set( { "v" }, "<S-TAB>", "<gv", {
    desc = "Unindent selected lines",
} )
