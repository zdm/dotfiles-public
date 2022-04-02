if exists("b:did_PERL_ftplugin")
    finish
endif

let b:did_PERL_ftplugin = 1

" add ':' to the keyword characters<Esc>
" tokens like 'File::Find' are recognized as one keyword
setlocal iskeyword+=:

" {<CR> always opens a block
inoremap <buffer> {<CR> {<CR>}<Esc>O
vnoremap <buffer> {<CR> s{<CR>}<Esc>kp=iB

inoremap <buffer> ## ## no critic qw[]<Esc>i
