" vim:foldmethod=marker

if !$XDG_CONFIG_HOME | let $XDG_CONFIG_HOME = fnamemodify( stdpath("config"), ":h" ) | endif
if !$XDG_DATA_HOME | let $XDG_DATA_HOME = fnamemodify( stdpath("data"), ":h" ) | endif

" language, encoding {{{
let $LANG = 'en'

if has( "win32" )
    language English
else
    " language C.UTF-8
    " language en_GB.UTF-8
endif

set langmenu=none
set encoding=utf-8
" }}}

" terminal, gui {{{
autocmd GUIEnter * simalt ~X
" set guifont=LiterationMono\ Nerd\ Font:h10:cRUSSIAN

set nocompatible

set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175

set termguicolors

if has( "win32" )
    source $VIMRUNTIME/scripts/mswin.vim
endif
" }}}

filetype plugin indent on
set modeline

" folding {{{
function s:fold_substitute_line ( line )
    if a:line == ""
        return  "▸"
    else
        return  substitute( substitute( a:line, '^ ', "▸", "" ), ' ', ".", "g" )
    endif
endfunction

function s:fold_text ()

    " replace tabs with spaces
    let l:line = substitute( getline( v:foldstart ), '\t', repeat( " ", &tabstop ), "g" )

    " remove trailing spaces
    let l:line = substitute( l:line, ' \+$', "", "" )

    let l:line = substitute( line, '^\( *\)', '\=s:fold_substitute_line( submatch( 1 ) )', "" )

    return l:line
endfunction

set foldtext=s:fold_text()
set foldenable
set foldlevel=99
set foldlevelstart=0
set foldmethod=manual
set foldcolumn=0 " auto:1 " controlled by statuscolumn
set fillchars+=foldopen:▾,foldclose:▸,foldsep:┋
" }}}

syntax manual

" colors
set background=dark
set cursorline
set nocursorcolumn
set hlsearch

" backspace and cursor keys wrap to previous/next line
set backspace=indent,eol,start whichwrap+=<,>,[,]

set history=50   " keep 50 lines of command line history
set ruler        " show the cursor position all the time
set showcmd      " display incomplete commands
set incsearch    " you will see results while you type
set ignorecase   " ignore case when searching
set smartcase    " use smartcase

set nobackup

" swap
if !isdirectory( stdpath( "data" ) . "/swap" ) | call mkdir(stdpath("data") . "/swap", "p", 0700) | endif
exec "set dir=" . stdpath( "data" ) . "/swap//"
" swap is disabled
set noswapfile

" undo
set undofile
if !isdirectory( stdpath( "data" ) . "/undo" ) | call mkdir( stdpath( "data" ) . "/undo", "p", 0700 ) | endif
exec "set undodir=" . stdpath( "data" ) . "/undo"

" set cryptmethod=blowfish2 " not supported in nvim

set scrolloff=2
set wrap         " включаем перенос строк
" set linebreak    " перенос строк по словам, а не по буквам
set tabstop=4    " размер табуляции
set shiftwidth=4 " размер сдвига при нажатии на клавиши << и >>
set autoindent   " копирует отступ от предыдущей строки
set smartindent  " включаем 'умную' автоматическую расстановку отступов

set number " show line numbers
set mouse=a

" spelling && keyboard layout {{{
if !isdirectory(stdpath("data") . "/spell") | call mkdir(stdpath("data") . "/spell", "p", 0700) | endif
exec "set spellfile=" . stdpath("data") . "/spell/default.add"
set mousemodel=popup_setpos
set imsearch=-1
" }}}

" file settings {{{
set fileencodings=ucs-bom,utf-8,cp1251
set fileformats=unix,dos
set fileformat=unix
set nobomb
" }}}

" session
set sessionoptions=buffers,curdir,folds,slash,tabpages,unix,winsize

" views
" exec "set viminfo='50,<100,s100,!,n" . stdpath( "data" ) . "/.viminfo"

set viewoptions=cursor,folds,options,slash,unix
exec "set viewdir=" . stdpath( "data" ) . "/view"

" tabline
set laststatus=2
set showtabline=2

" disable bell
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

set noautoread " don't reload modified file automatically
autocmd FocusGained * :checktime " notify on file modified

" set fill char for diff
set fillchars+=diff:╱

" open new tab with <C-t> {{{
nnoremap <silent> <C-t> :tabnew<CR>
inoremap <silent> <C-t> <ESC>:tabnew<CR>a
vnoremap <silent> <C-t> <ESC>:<C-o>tabnew<CR>gv
" }}}

" switch tabs with <C-PageUp>, <C-PageDown> {{{
nnoremap <silent> <C-PageUp> :tabprevious<CR>
inoremap <silent> <C-PageUp> <ESC>:tabprevious<CR>a
vnoremap <silent> <C-PageUp> <ESC>:tabprevious<CR>gv

nnoremap <silent> <C-PageDown> :tabnext<CR>
inoremap <silent> <C-PageDown> <ESC>:tabnext<CR>a
vnoremap <silent> <C-PageDown> <ESC>:tabnext<CR>gv
" }}}

" switch tabs with <C-TAB>, <C-S-TAB> {{{
nnoremap <silent> <C-S-TAB> :tabprevious<CR>
inoremap <silent> <C-S-TAB> <ESC>:tabprevious<CR>a
vnoremap <silent> <C-S-TAB> <ESC>:tabprevious<CR>gv

nnoremap <silent> <C-TAB> :tabnext<CR>
inoremap <silent> <C-TAB> <ESC>:tabnext<CR>a
vnoremap <silent> <C-TAB> <ESC>:tabnext<CR>gv
" }}}

" move tabs with <C-S-PageUp>, <C-S-PageDown> {{{
nnoremap <silent> <C-S-PageUp> :-tabm<CR>
inoremap <silent> <C-S-PageUp> <ESC>:-tabm<CR>a
vnoremap <silent> <C-S-PageUp> <ESC>:-tabm<CR>gv

nnoremap <silent> <C-S-PageDown> :+tabm<CR>
inoremap <silent> <C-S-PageDown> <ESC>:+tabm<CR>a
vnoremap <silent> <C-S-PageDown> <ESC>:+tabm<CR>gv
" }}}

" move tabs with <C-S-J>, <C-S-K> {{{
nnoremap <silent> <C-S-J> :-tabm<CR>
inoremap <silent> <C-S-J> <ESC>:-tabm<CR>a
vnoremap <silent> <C-S-J> <ESC>:-tabm<CR>gv

nnoremap <silent> <C-S-K> :+tabm<CR>
inoremap <silent> <C-S-K> <ESC>:+tabm<CR>a
vnoremap <silent> <C-S-K> <ESC>:+tabm<CR>gv
" }}}

" make <TAB> ident code {{{
nnoremap <TAB>   I<TAB><ESC>
nnoremap <S-TAB> ^i<BS><ESC>
vnoremap <TAB>   >gv
vnoremap <S-TAB> <gv
" }}}

" * - highlites word under cursor {{{
nnoremap <silent> * *N
" }}}

" <SPACE> - cleanup search highlight in NORMAL mode {{{
nnoremap <silent> <Space> :noh<CR>
" }}}

" <CR> - switch VIM to INSERT mode {{{
nnoremap <CR> a
" }}}

" <C-W><C-ARROW> - move windows (not work in console) {{{
nnoremap <C-W><C-Left> <C-W>H
nnoremap <C-W><C-Right> <C-W>L
nnoremap <C-W><C-Up> <C-W>K
nnoremap <C-W><C-Down> <C-W>J
" }}}

" open current buffer in the new tab {{{
nnoremap <C-W>t <C-W>T
" }}}

" remap Up and Down to move inside visible lines {{{
nnoremap <expr> <Up>   v:count ? 'k' : 'gk'
nnoremap <expr> <Down> v:count ? 'j' : 'gj'

" nnoremap <S-Up>   gh<C-o>gk
" nnoremap <S-Down> gh<C-o>gj

" XXX produces garbage
" inoremap <Up>     <C-o>gk
" inoremap <Down>   <C-o>gj

" inoremap <S-Up>   <C-o>gh<C-o>gk
" inoremap <S-Down> <C-o>gh<C-o>gj

" xnoremap <Up>     gk
" xnoremap <Down>   gj
" xnoremap <S-Up>   k
" xnoremap <S-Down> j
" xnoremap <Left>   h
" xnoremap <Right>  l
" snoremap <S-Up>   <C-o>gk
" snoremap <S-Down> <C-o>gj
" }}}

" \ss - syntax refresh {{{
function! SyntaxRefresh ()
    let l:cursor_pos = getpos( "." )

    " refresh treesitter, if used
lua << EOF
    if require( "utils" ).has_treesitter() then
        require( "utils" ).parse_treesitter()
    end
EOF

    " refresh syntax, if used
    if getbufvar( "%", "&syntax" ) == "on"
        syn sync fromstart
    endif

    call setpos( ".", l:cursor_pos )

    " open fold under the cursor
    exec( "setlocal foldmethod=" . &foldmethod )
    normal zM
    normal zv

    " center cursor on the screen
    normal zz

    return
endfunction

nnoremap <silent> <Leader>ss :call SyntaxRefresh()<CR>
inoremap <silent> <Leader>ss <ESC>:call SyntaxRefresh()<CR>a
vnoremap <silent> <Leader>ss <ESC>:call SyntaxRefresh()<CR>gv
" }}}

" helper - unite F2 menu {{{
nnoremap <silent> <F2> :Unite -buffer-name=helper -toggle -prompt-direction=top -start-insert -no-restore menu:helper<CR>
inoremap <silent> <F2> <C-o>:Unite -buffer-name=helper -toggle -prompt-direction=top -start-insert -no-restore menu:helper<CR>
vnoremap <silent> <F2> <ESC>:Unite -buffer-name=helper -toggle -prompt-direction=top -start-insert -no-restore menu:helper<CR>
" }}}

" set titlestring {{{
function! SetTitleString () "{{{
    let title = ""

    if &mod
        let title .= "[+] "
    endif

    let name = expand( "%F" )

    " no name
    if empty( name )
        let title .= "[No Name]"

    " neovim terminal
    elseif name =~ "term://"
        let title = substitute( name, '\(term:\)//.*:\(.*\)', '\1 \2', "" )

    " filename
    else
        let title .= fnamemodify( name, ":t" )

        let title .= " (" . fnamemodify( name, ":p:h" ) . ")"
    endif

    let title = substitute( title, '\\', '/', "g" )

    return title
endfunction " }}}

set titlestring=%{SetTitleString()}

" mandatory for neovim-qt
set title
" }}}

" prevent create .netrwhist
let g:netrw_dirhistmax = 0

" disable highlight for html comments
let html_wrong_comments = 1

" allow redefine tab width for yaml
let g:yaml_recommended_style = 0

" make highlight for "sh" files  compatible with "bash"
let g:is_posix = 1

" configure folding for "sh" scripts
let g:sh_fold_enabled = 3

" disable hide of double quotes in json
let g:vim_json_conceal = 0

" use "::" comments for "dosbatch" filetype
let g:dosbatch_colons_comment = 1

" load plugins
lua require( "config.lazy" )
