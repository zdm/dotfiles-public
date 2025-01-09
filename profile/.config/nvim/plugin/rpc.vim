" vim:foldmethod=marker

if exists( 'g:rpc#loaded' )
    finish
endif

let g:rpc#hostname = get( g:, "rpc#hostname", "127.0.0.1" )
let g:rpc#port = get( g:, "rpc#port", 55556 )

let g:rpc#loaded = 1
let g:rpc#socket_ready = v:null
let s:job = 0
let s:channel = 0
let s:ft_type = {
    \ "javascript": "text/javascript",
    \ "typescript": "application/x-typescript",
    \ "ant": "text/xml"
\ }

command! Lint call s:lint_file( 'lint' )
command! LintFormat call s:lint_file( 'format' )
command! LintCompress call s:lint_file( 'compress' )
command! LintObfuscate call s:lint_file( 'obfuscate' )

command! BrowserPrint call s:browser_print()

func! s:check_socket () " {{{

    " check socket connected
    if s:channel
        for channel in nvim_list_chans()

            " socket connected
            if channel.id == s:channel | return v:true | endif
        endfor

        let s:channel = 0
    endif

    let s:channel = sockconnect( "tcp", g:rpc#hostname . ":" . g:rpc#port, { "rpc": v:true } )

    if s:channel
        return v:true
    else

        " clear connection error message
        silent! redraw!

        return v:false
    endif
endfunc " }}}

func! s:check_channel () " {{{

    " start RPC server
    if !s:check_socket()
        echom "Starting RPC server"

        if has( 'win16' ) || has( 'win32' ) || has( 'win64' )
            let s:job = jobstart( "softvisio-cli.cmd rpc start" )
        else
            let s:job = jobstart( "softvisio-cli rpc start" )
        endif

        sleep 3
    endif

    let n = 10

    while n > 0
        let n -= 1

        if s:check_socket()
            break
        else
            echom "Connecting to the RPC server"

            sleep 1
        endif
    endwhile

    " unable to connect
    if s:channel
        silent! redraw
    else
        echohl ErrorMsg
        echo "Failed to connect to the RPC server"
        echohl None
    endif

endfunc " }}}

func! s:lint_file ( type ) " {{{
    let l:buf = join( getline( 1, '$' ), "\n" )

    silent! redraw

    if l:buf == ''
        echohl Comment
        echo "Buffer is empty"
        echohl None

        return
    endif

    call s:check_channel()

    if s:channel
        let l:buf .= "\n"

        echo a:type . ":  run source filter..."

        let l:type = get( s:ft_type, &ft )
        let l:path = expand( '%:p' )

        if ( l:type == v:null ) | let l:type = "" | endif
        if ( l:path == "" ) | let l:path = "no-name" | endif

        " special case for makefiles
        if ( &ft == "make" )
            let l:path = fnamemodify( l:path, ":h" ) . "/Makefile"

        " add &ft as extension if mime type wasn't found and extension ne &ft
        elseif ( l:type == "" && &ft != "" && expand( "%:e" ) != &ft )
            let l:path .= "." . &ft
        endif

        let l:res = rpcrequest( s:channel, "lint-file", { "action": a:type, "cwd": getcwd(), "path": l:path, "type": l:type, "buffer": l:buf } )

        if l:res.meta.isModified
            set syntax=off

            let l:cursor_pos = getpos( "." )

            %delete
            put =l:res.data
            1delete 1

            set syntax=on
            set ff=unix
            set fenc=utf-8
            syn sync fromstart

            call setpos( ".", l:cursor_pos )

            if g:loaded_fastfold
                FastFoldUpdate
            endif
            normal zv " unfold lines under cursor
            normal zz " center cursor on screen
        endif

        silent! redraw

        " error
        if l:res.status >= 300

            " multi-line error
            if len( split( res.status_text, '\n' ) ) > 1
                echohl ErrorMsg
                echo a:type . " errors:"
                echohl None
                echo res.status_text

            " single-line error
            else
                echohl ErrorMsg
                echo a:type . ": " . res.status_text
                echohl None
            endif

        " warning
        elseif l:res.status >= 201
            echohl WarningMsg
            echo a:type . ": " . res.status_text
            echohl None

        " ok
        else
            echohl Comment
            echo a:type . ": " . res.status_text
            echohl None
        endif
    endif

    return
endfunc " }}}

func! s:browser_print () " {{{
    let l:buf = join( getline( 1,'$' ), "\n" )

    if l:buf == ''
        echohl Comment
        echo "Buffer is empty"
        echohl None

        return
    endif

    call s:check_channel()

    if s:channel
        let l:buf .= "\n"

        let l:res = rpcrequest( s:channel, "browser-print", { "encoding": &encoding, "font": &gfn, "data": l:buf } )
    endif

    return
endfunc " }}}
