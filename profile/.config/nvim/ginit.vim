autocmd ColorScheme * highlight CursorLine term=NONE cterm=bold ctermbg=NONE ctermfg=NONE gui=bold guibg=Grey25 guifg=NONE
autocmd ColorScheme * highlight SignColumn term=NONE cterm=bold ctermbg=NONE ctermfg=NONE gui=bold guibg=NONE   guifg=NONE
autocmd ColorScheme * highlight Folded     term=NONE cterm=bold ctermbg=NONE ctermfg=178  gui=NONE guibg=Grey30 guifg=Gold

colorscheme desert

hi Pmenu guifg=grey100 guibg=grey10
hi PmenuSel gui=bold guifg=grey100 guibg=grey45
hi PmenuSbar guifg=grey100 guibg=grey10
hi PmenuThumb guifg=grey100

" enable mouse
set mouse=a

" set editor font
if exists( ":GuiFont" )
    GuiFont Liberation Mono:h8
endif

" disable GUI tabline
if exists( ":GuiTabline" )
    GuiTabline 0
endif

" disable GUI popupmenu
if exists( ":GuiPopupmenu" )
    GuiPopupmenu 0
endif

" disable GUI scrollbar
" if exists( ":GuiScrollBar" )
"     GuiScrollBar 0
" endif

" right click context menu (copy-cut-paste)
if exists( ":GuiShowContextMenu" )
    nnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>
    inoremap <silent><RightMouse> <Esc>:call GuiShowContextMenu()<CR>
    vnoremap <silent><RightMouse> :call GuiShowContextMenu()<CR>g
endif
