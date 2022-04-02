if exists( 'g:loaded_template' ) | finish | endif
let g:loaded_template = 1

augroup template
    autocmd!
    autocmd FileType * if line2byte( line( '$' ) + 1 ) == -1 | call s:loadtemplate( &filetype, expand('<afile>:e') ) | endif
augroup END

function! s:globpathlist( path, ... )
    let i = 1
    let result = a:path
    while i <= a:0
        let result = substitute( escape( globpath( result, a:{i} ), ' ,\' ), "\n", ',', 'g' )
        if strlen( result ) == 0 | return '' | endif
        let i = i + 1
    endwhile
    return result
endfunction

function! s:loadtemplate( filetype, fext )
    if a:fext != ''
        let templatefile = matchstr( s:globpathlist( &runtimepath, 'templates', a:fext ), '\(\\.\|[^,]\)*', 0 )
        if strlen( templatefile ) == 0
            if a:filetype != ''
                let templatefile = matchstr( s:globpathlist( &runtimepath, 'templates', a:filetype ), '\(\\.\|[^,]\)*', 0 )
                if strlen( templatefile ) == 0
                    return
                endif
            else
                return
            endif
        endif
    else
        return
    endif

    silent execute 1 'read' templatefile
    1 delete

    let cursorline = getline( '$' )
    if matchstr( cursorline, '^\s*"\s*cursor:' ) != ""
        let y = matchstr( cursorline, '^\s*"\s*cursor:\s*\zs\d\+\ze' )
        let x = matchstr( cursorline, '^\s*"\s*cursor:\s*\d\+\s\+\zs\d\+\ze' )
        if !strlen(x) | let x = 0 | endif
        if !strlen(y) | let y = 0 | endif
        silent! $ foldopen!
        $ delete
        call cursor(y,x)
    endif

    set nomodified
endfunction

command -nargs=1 New new | set ft=<args>
