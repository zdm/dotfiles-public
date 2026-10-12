" enable mouse
set mouse=a

" set editor font
if exists( ":GuiFont" )
    GuiFont LiterationMono Nerd Font:h8
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
