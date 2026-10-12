-- {<CR> always opens a block
vim.keymap.set( "i", "{<CR>", "{<CR>}<Esc>O", { buffer = true } )
vim.keymap.set( "v", "{<CR>", "s{<CR>}<Esc>kp=iB", { buffer = true } )
