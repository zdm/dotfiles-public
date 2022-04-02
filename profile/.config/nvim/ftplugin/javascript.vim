if exists( "b:did_JAVASCRIPT_ftplugin" )
    finish
endif

let b:did_JAVASCRIPT_ftplugin = 1

" {<CR> always opens a block
inoremap <buffer> {<CR>  {<CR>}<Esc>O
vnoremap <buffer> {<CR> s{<CR>}<Esc>kp=iB
