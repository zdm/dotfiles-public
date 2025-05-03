" vim:foldmethod=marker

if !$XDG_CONFIG_HOME | let $XDG_CONFIG_HOME = fnamemodify( stdpath("config"), ":h" ) | endif
if !$XDG_DATA_HOME | let $XDG_DATA_HOME = fnamemodify( stdpath("data"), ":h" ) | endif

" language, encoding {{{
let $LANG = 'en'

if has('win16') || has('win32') || has('win64')
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
set guifont=Liberation\ Mono:h10:cRUSSIAN
set guioptions=ceMgt

set nocompatible

set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175

set termguicolors

if has('win16') || has('win32') || has('win64')
    source $VIMRUNTIME/mswin.vim
endif
" }}}

" init dein
" {{{
let g:bundle_path = stdpath( "data" ) . "/bundle"

" clone dein if not extists
if !isdirectory( g:bundle_path . "/repos/github.com/Shougo/dein.vim" )
    silent exec "!git clone https://github.com/Shougo/dein.vim " . g:bundle_path . "/repos/github.com/Shougo/dein.vim"
endif

if has( 'win16' ) || has( 'win32' ) || has( 'win64' )
    let g:dein#types#git#command_path="git.exe"
endif

exec "set rtp+=" . g:bundle_path . "/repos/github.com/Shougo/dein.vim"
" }}}

" add plugins
if dein#load_state( expand( g:bundle_path ) ) " {{{
    call dein#begin( expand( g:bundle_path ) )

    call dein#add( g:bundle_path . "/repos/github.com/Shougo/dein.vim" )

    " call dein#add( "Shougo/vimproc.vim", { "build": "gmake" } )
    call dein#add( "Shougo/unite.vim" )
    call dein#add( "Shougo/unite-dein" )
    call dein#add( "Shougo/neomru.vim" )
    " call dein#add( "easymotion/vim-easymotion" )
    call dein#add( "Shougo/unite-outline" )
    call dein#add( "mbbill/undotree" )
    call dein#add( "powerman/vim-plugin-viewdoc" )
    " call dein#add( "nathanaelkane/vim-indent-guides.git" )
    call dein#add( "mhinz/vim-signify" )
    call dein#add( "Yggdroot/indentLine" )

    " airline
    call dein#add( "vim-airline/vim-airline" )
    call dein#add( "vim-airline/vim-airline-themes" )

    " xkbd
    call dein#add( "lyokha/vim-xkbswitch", { "depends": "DeXP/xkb-switch-win" } )
    call dein#add( "DeXP/xkb-switch-win" )

    " treesitter
    call dein#add( "nvim-treesitter/nvim-treesitter", { "hook_post_update": "TSUpdate" } )

    " folding
    call dein#add( "foalford/vim-markdown-folding" )

    " comments
    call dein#add( "numToStr/Comment.nvim" )
    call dein#add( "JoosepAlviste/nvim-ts-context-commentstring" )

    " other plugins
    " call dein#add( "arecarn/vim-crunch" )
    call dein#add( "tpope/vim-fugitive" )
    " call dein#add( "vim-scripts/autocorrect.vim" )
    call dein#add( "uguu-org/vim-matrix-screensaver" )
    call dein#add( "vim-scripts/DirDiff.vim" )
    " call dein#add( "chrisbra/NrrwRgn" )
    call dein#add( "zhimsel/vim-stay" )

    " completion
    call dein#add( "hrsh7th/nvim-cmp" )
    call dein#add( "hrsh7th/cmp-vsnip" )
    call dein#add( "hrsh7th/vim-vsnip" )
    call dein#add( "hrsh7th/cmp-calc" )
    " call dein#add( "rafamadriz/friendly-snippets" )

    " XXX disabled, because syntax/javascript.vim conflicted when used with dein
    " call dein#add( "mattn/emmet-vim" )

    " call dein#add( "vim-scripts/Marks-Browser" )
    " call dein#add( "w0rp/ale" )
    " call dein#add( "hexman.vim" )
    " call dein#add( "motemen/xslate-vim" )
    " call dein#add( "highlight.vim" )
    " call dein#add( "tpope/vim-surround" )

    " add vsnip
    exec "set rtp=" . substitute( stdpath( "config" ) . "/vsnip," . &rtp, " ", '\\\ ', "g" )

    call dein#end()
    call dein#save_state()
endif " }}}

" plugins settings
" unite {{{
let g:unite_data_directory = stdpath("data") . "/unite"
let g:unite_source_bookmark_directory = stdpath("config") . "/unite/bookmark"
let g:unite_force_overwrite_statusline = 0
let g:unite_cursor_line_highlight = 'CursorLine'
let g:unite_source_menu_menus = {}
let g:unite_winheight = 20
let g:unite_winwidth = 40
let g:unite_split_rule = 'botright'

autocmd FileType unite call s:uniteCustomization()
function! s:uniteCustomization()
    nmap <silent><buffer> <ESC> <Plug>(unite_exit)

    nnoremap <silent><buffer><expr> <C-t> unite#do_action('tabopen')
    inoremap <silent><buffer><expr> <C-t> unite#do_action('tabopen')

    nnoremap <silent><buffer><expr> <C-s> unite#do_action('split')
    inoremap <silent><buffer><expr> <C-s> unite#do_action('split')

    nnoremap <silent><buffer><expr> <C-v> unite#do_action('vsplit')
    inoremap <silent><buffer><expr> <C-v> unite#do_action('vsplit')

    nnoremap <silent><buffer><expr> <C-d> unite#do_action('delete')
    inoremap <silent><buffer><expr> <C-d> unite#do_action('delete')

    nnoremap <silent><buffer><expr> <C-CR> unite#do_action('tabswitch')
    inoremap <silent><buffer><expr> <C-CR> unite#do_action('tabswitch')
endfunction

nnoremap <silent> <F4> :Unite -buffer-name=buffers -toggle -prompt-direction=top -start-insert -no-restore buffer<CR>
inoremap <silent> <F4> <C-o>:Unite -buffer-name=buffers -toggle -prompt-direction=top -start-insert -no-restore buffer<CR>
vnoremap <silent> <F4> <ESC>:Unite -buffer-name=buffers -toggle -prompt-direction=top -start-insert -no-restore buffer<CR>

if has('win16') || has('win32') || has('win64')
    nnoremap <silent> <F3> :Unite -buffer-name=MRU -toggle -prompt-direction=top -start-insert -no-restore bookmark:default-windows neomru/file<CR>
    inoremap <silent> <F3> <C-o>:Unite -buffer-name=MRU -toggle -prompt-direction=top -start-insert -no-restore bookmark:default-windows neomru/file<CR>
    vnoremap <silent> <F3> <ESC>:Unite -buffer-name=MRU -toggle -prompt-direction=top -start-insert -no-restore bookmark:default-windows neomru/file<CR>
else
    nnoremap <silent> <F3> :Unite -buffer-name=MRU -toggle -prompt-direction=top -start-insert -no-restore bookmark:default-linux neomru/file<CR>
    inoremap <silent> <F3> <C-o>:Unite -buffer-name=MRU -toggle -prompt-direction=top -start-insert -no-restore bookmark:default-linux neomru/file<CR>
    vnoremap <silent> <F3> <ESC>:Unite -buffer-name=MRU -toggle -prompt-direction=top -start-insert -no-restore bookmark:default-linux neomru/file<CR>
endif
" }}}

" Shougo/neomru.vim {{{
let g:neomru#file_mru_path = g:unite_data_directory . "/neomru/file"
let g:neomru#directory_mru_path = g:unite_data_directory . "/neomru/directory"
" }}}

" vim-scripts/Marks-Browser {{{
" nnoremap <silent> <F7> :MarksBrowser<CR>
" inoremap <silent> <F7> <C-o>:MarksBrowser<CR>
" vnoremap <silent> <F7> <ESC>:MarksBrowser<CR>
" }}}

" Shougo/unite-outline {{{
nnoremap <silent> <F8> :Unite -buffer-name=outline -toggle -vertical -direction=botright -winwidth=60 -start-insert -no-restore outline<CR>
inoremap <silent> <F8> <C-o>:Unite -buffer-name=outline -toggle -vertical -direction=botright -winwidth=60 -start-insert -no-restore outline<CR>
vnoremap <silent> <F8> <ESC>:Unite -buffer-name=outline -toggle -vertical -direction=botright -winwidth=60 -start-insert -no-restore outline<CR>
" }}}

" mbbill/undotree {{{
let g:undotree_WindowLayout = 2
let g:undotree_SplitWidth = 40
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_DiffAutoOpen = 0

nnoremap <silent> <F10> :UndotreeToggle<CR>
inoremap <silent> <F10> <C-o>:UndotreeToggle<CR>
vnoremap <silent> <F10> <ESC>:UndotreeToggle<CR>
" }}}

" vim-airline/vim-airline {{{
let g:airline_theme = 'wombat'
let g:airline_symbols_ascii = 1

" extensions
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#coc#enabled = 0

set guioptions-=e " disable gvim tabbar, comment this if tabline is not enabled
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#close_symbol = '×'
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#xkblayout#enabled = 0

let g:airline#extensions#tabline#formatter = "short_path"
" let g:airline#extensions#tabline#fnamecollapse = 0
" let g:airline#extensions#tabline#fnamemod = ':t'

" customize airline sections
" function! AirlineInit()
    " let g:airline_section_x = airline#section#create_left(['session'])
" endf
" autocmd VimEnter * call AirlineInit()
" }}}

" lyokha/vim-xkbswitch {{{
let g:XkbSwitchEnabled = 1
let g:XkbSwitchIMappings = ['ru']
let g:XkbSwitchIMappingsSkipFt = ['tex']
let g:XkbSwitchNLayout = 'US'
let g:XkbSwitchILayout = 'US'
if has('unix')
    let g:XkbSwitchLib = ""
elseif has('win64')
    let g:XkbSwitchLib = g:bundle_path . "/.cache/init.vim/.dein/bin/libxkbswitch64.dll"
elseif has('win32')
    let g:XkbSwitchLib = g:bundle_path . "/.cache/init.vim/.dein/bin/libxkbswitch32.dll"
endif
" }}}

" powerman/vim-plugin-viewdoc {{{
let g:viewdoc_openempty = 1
" if !exists('g:no_plugin_abbrev') && !exists('g:no_viewdoc_abbrev')
"     cnoreabbrev <expr> h  getcmdtype()==':' && getcmdline()=='h'  ? 'ViewDocHelp'  : 'h'
"     cnoreabbrev <expr> h! getcmdtype()==':' && getcmdline()=='h!' ? 'ViewDocHelp'  : 'h!'

"     cnoreabbrev <expr> pd  getcmdtype()==':' && getcmdline()=='pd'  ? 'ViewDocPerl'  : 'pd'
"     cnoreabbrev <expr> pd! getcmdtype()==':' && getcmdline()=='pd!' ? 'ViewDocPerl'  : 'pd!'
" endif
" }}}

" nathanaelkane/vim-indent-guides.git {{{
let g:indent_guides_auto_colors = 1
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
" }}}

" mhinz/vim-signify {{{
let g:signify_vcs_list = [ 'git' ]
let g:signify_realtime = 1

autocmd ColorScheme * highlight DiffAdd    term=bold cterm=bold ctermbg=22  ctermfg=Green gui=bold guibg=DarkGreen guifg=Green
autocmd ColorScheme * highlight DiffChange term=bold cterm=bold ctermbg=24  ctermfg=Cyan  gui=bold guibg=DarkCyan  guifg=Cyan
autocmd ColorScheme * highlight DiffDelete term=bold cterm=bold ctermbg=124 ctermfg=Red   gui=bold guibg=DarkRed   guifg=Red
" }}}

" Yggdroot/indentLine {{{
let g:indentLine_enabled = 1 " enabled by default
" let g:indentLine_char = '│'
" let g:indentLine_showFirstIndentLevel = 1
" let g:indentLine_fileType = ['pl', 'pm', 'perl', 'js']
let g:indentLine_fileTypeExclude = ['json', 'markdown']
let g:indentLine_faster = 1 " works faster, but issues are possible

nnoremap <silent> <Leader>ii :IndentLinesToggle<CR>
inoremap <silent> <Leader>ii <ESC>:IndentLinesToggle<CR>a
vnoremap <silent> <Leader>ii <ESC>:IndentLinesToggle<CR>gv
" }}}

" XXX
" comments {{{
lua <<EOF
require( "ts_context_commentstring" ).setup( {
    enable_autocmd = false,
} )

require( "Comment" ).setup( {
    padding = true,
    sticky = true,
    ignore = "^$",
    mappings = {
        basic = false,
        extra = false,
    },
    pre_hook = require( "ts_context_commentstring.integrations.comment_nvim" ).create_pre_hook(),
} )

local api = require( "Comment.api" )
local config = require( "Comment.config" ):get()

vim.keymap.set( { "n", "i" }, "<Leader>c", function ()
    api.toggle.linewise.current()
    vim.cmd( "normal! j" )
end )

vim.keymap.set( "v", "<Leader>c", api.call( "toggle.linewise", "g@" ), { expr = true } )
vim.keymap.set( "v", "<Leader>cc", api.call( "toggle.blockwise", "g@" ), { expr = true } )

local ft = require( "Comment.ft" )

ft.set( "dosbatch", ":: %s" )

-- XXX
-- let g:tcomment#replacements_xml = {
-- \   '<!--': '<!-&#45;',
-- \   '-->': '&#45;->'
-- \ }

EOF

" }}}

" completion {{{
lua <<EOF
    local cmp = require( "cmp" )

    cmp.setup( {
        snippet = {
            expand = function( args )
                vim.fn["vsnip#anonymous"]( args.body )
            end,
        },
        mapping = cmp.mapping.preset.insert( {
            ['<Up>'] = function( fallback )
                if cmp.visible() then
                    cmp.abort()
                end

                fallback()
            end,
            ['<Down>'] = function( fallback )
                if cmp.visible() then
                    cmp.abort()
                end

                fallback()
            end,
            ['<C-Up>'] = cmp.mapping.select_prev_item( { behavior = cmp.SelectBehavior.Select } ),
            ['<C-Down>'] = cmp.mapping.select_next_item( { behavior = cmp.SelectBehavior.Select } ),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm( { select = false } ),
        } ),
        sources = cmp.config.sources( {
            { name = 'vsnip' },
            { name = 'calc' },
        } )
    } )
EOF

set omnifunc=syntaxcomplete#Complete
set complete-=i
set iskeyword+=:
set completeopt=menuone,noselect

let g:vsnip_snippet_dir = stdpath("config") . "/vsnip"
" }}}

" treesitter, foldind {{{
set foldenable
set foldlevel=99
set foldlevelstart=0
set foldmethod=manual
set foldcolumn=1

lua <<EOF
require( "nvim-treesitter.install" ).prefer_git = false

require( "nvim-treesitter.configs" ).setup( {
    ensure_installed = {
        "awk",
        "bash",
        "c",
        "cmake",
        "comment",
        "cpp",
        "css",
        "csv",
        "diff",
        "dockerfile",
        "editorconfig",
        "embedded_template",
        "forth",
        "git_config",
        "gitattributes",
        "gitignore",
        "gpg",
        "graphql",
        "html",
        "ini",
        "javascript",
        "jsdoc",
        "json",
        "json5",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "nginx",
        "pem",
        "perl",
        "po",
        "pod",
        "powershell",
        "query",
        "scss",
        "sql",
        "ssh_config",
        "toml",
        "tsv",
        "typescript",
        "vim",
        "vimdoc",
        "vue",
        "xml",
        "yaml"
    },
    sync_install = false,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = {
        enable = true
    },
    incremental_selection = {
        enable = true,
    --     keymaps = {
    --         init_selection = "gnn", -- set to `false` to disable one of the mappings
    --         node_incremental = "grn",
    --         scope_incremental = "grc",
    --         node_decremental = "grm",
    --     },
    },
} )

-- DOCS: https://github.com/nvim-treesitter/nvim-treesitter/tree/master/queries
require( "vim.treesitter.query" ).set( "javascript", "folds", [[
    [
        (arrow_function)
        (function_expression)
        (function_declaration)
        (method_definition)
        (generator_function)
        (generator_function_declaration)
        (template_string)
        (comment)
    ] @fold
]] )

require( "vim.treesitter.query" ).set( "vim", "folds", [[
    [
        (function_definition)
        (lua_statement)
        (ruby_statement)
        (python_statement)
        (perl_statement)
        (autocmd_statement)
    ] @fold
]] )

require( "vim.treesitter.query" ).set( "lua", "folds", [[
    [
        (function_declaration)
        (function_definition)
    ] @fold
]] )

require( "vim.treesitter.query" ).set( "bash", "folds", [[
    [
        (function_definition)
        (heredoc_redirect)
    ] @fold
]] )

vim.api.nvim_create_autocmd( { "FileType" }, {
    callback = function ()
        if require( "nvim-treesitter.parsers" ).has_parser() then
            vim.bo.syntax = "off"
            vim.wo.foldmethod = "expr"

            if vim.bo.filetype == "markdown" then
                vim.wo.foldexpr = "StackedMarkdownFolds()"
            else
                vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
            end
        else
            vim.bo.syntax = "on"
            vim.wo.foldmethod = "syntax"
        end
    end
} )

EOF
" }}}

" prevent create .netrwhist
let g:netrw_dirhistmax = 0

" install missed plugins
if dein#check_install() | call dein#install() | endif

filetype plugin indent on
set modeline

" colors {{{
set background=dark

autocmd ColorScheme * highlight CursorLine term=NONE cterm=bold ctermbg=NONE ctermfg=NONE gui=bold guibg=Grey10 guifg=NONE
autocmd ColorScheme * highlight SignColumn term=NONE cterm=bold ctermbg=NONE ctermfg=NONE gui=bold guibg=NONE   guifg=NONE
autocmd ColorScheme * highlight Folded     term=NONE cterm=bold ctermbg=NONE ctermfg=NONE gui=bold guibg=NONE   guifg=Gold

autocmd ColorScheme * highlight link @comment.note Todo

colorscheme default

set cursorline
set nocursorcolumn
set hlsearch

syntax manual

hi Pmenu guifg=#c0c0c0 guibg=#404080
hi PmenuSel gui=bold guifg=#c0c0c0 guibg=#2050d0
hi PmenuSbar guifg=blue guibg=darkgray
hi PmenuThumb guifg=#c0c0c0
" }}}

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
if !isdirectory(stdpath("data") . "/swap") | call mkdir(stdpath("data") . "/swap", "p", 0700) | endif
exec "set dir=" . stdpath("data") . "/swap//"
" swap is disabled
set noswapfile

" undo
set undofile
if !isdirectory(stdpath("data") . "/undo") | call mkdir(stdpath("data") . "/undo", "p", 0700) | endif
exec "set undodir=" . stdpath("data") . "/undo"

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
" exec "set viminfo='50,<100,s100,!,n" . stdpath("data") . "/.viminfo"

set viewoptions=cursor,folds,options,slash,unix
exec "set viewdir=" . stdpath("data") . "/view"

" tabline
set laststatus=2
set showtabline=2

" disable bell
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

set noautoread " don't reload modified file automatically
autocmd FocusGained * :checktime " notify on file modified

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
func! SyntaxRefresh ()
    let l:cursor_pos = getpos( "." )

    if getbufvar( "%", "&syntax" ) == "on"
        syn sync fromstart
    endif

    call setpos( ".", l:cursor_pos )

    " unfold block under the cursor
    exec( "setlocal foldmethod=" . &foldmethod )
    normal zM
    normal zv

    " center cursor on the screen
    normal zz

    return
endfunc

nnoremap <silent> <Leader>ss :call SyntaxRefresh()<CR>
inoremap <silent> <Leader>ss <ESC>:call SyntaxRefresh()<CR>a
vnoremap <silent> <Leader>ss <ESC>:call SyntaxRefresh()<CR>gv
" }}}

" sessions - unite F5 menu {{{
let g:unite_source_session_enable_auto_save = 1

nnoremap <silent> <F5> :Unite -buffer-name=session -toggle -prompt-direction=top -hide-source-names session session/new<CR>
inoremap <silent> <F5> <C-o>:Unite -buffer-name=session -toggle -prompt-direction=top -hide-source-names session session/new<CR>
vnoremap <silent> <F5> <ESC>:Unite -buffer-name=session -toggle -prompt-direction=top -hide-source-names session session/new<CR>
" }}}

" helper - unite F2 menu {{{
nnoremap <silent> <F2> :Unite -buffer-name=helper -toggle -prompt-direction=top -start-insert -no-restore menu:helper<CR>
inoremap <silent> <F2> <C-o>:Unite -buffer-name=helper -toggle -prompt-direction=top -start-insert -no-restore menu:helper<CR>
vnoremap <silent> <F2> <ESC>:Unite -buffer-name=helper -toggle -prompt-direction=top -start-insert -no-restore menu:helper<CR>
" }}}

" rpc lint mappings {{{
nnoremap <silent> <Leader>sd :Lint<CR>
inoremap <silent> <Leader>sd <ESC>:Lint<CR>
vnoremap <silent> <Leader>sd <ESC>:Lint<CR>

nnoremap <silent> <Leader>sf :LintFormat<CR>
inoremap <silent> <Leader>sf <ESC>:LintFormat<CR>
vnoremap <silent> <Leader>sf <ESC>:LintFormat<CR>

nnoremap <silent> <Leader>sc :LintCompress<CR>
inoremap <silent> <Leader>sc <ESC>:LintCompress<CR>
vnoremap <silent> <Leader>sc <ESC>:LintCompress<CR>

nnoremap <silent> <Leader>so :LintObfuscate<CR>
inoremap <silent> <Leader>so <ESC>:LintObfuscate<CR>
vnoremap <silent> <Leader>so <ESC>:LintObfuscate<CR>
" }}}

" set titlestring {{{
function! SetTitleString()
    let _ = ''

    let name = expand('%F')

    if empty(name)
        let _ .= '[No Name]'

        if &mod | let _ .= '+' | endif
    else
        if name =~ 'term://'
            " Neovim Terminal
            let _ = substitute(name, '\(term:\)//.*:\(.*\)', '\1 \2', '')

            if &mod | let _ .= '+' | endif
        else
            let _ .= fnamemodify(name, ':p:h:t') . '/' . fnamemodify(name, ':t')

            if &mod | let _ .= '+' | endif

            let _ .= ' (' . fnamemodify(name, ':p:h:h') . ')'
        endif
    endif

    return _
endfunction

" set titlestring=%{SetTitleString()}

set title " mandatory for neovim-qt
" }}}

exec "runtime ginit.vim"
