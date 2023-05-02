" vim:foldmethod=marker

if exists('g:rpc#loaded')
    finish
endif

let g:rpc#hostname = get( g:, "rpc#hostname", "127.0.0.1" )
let g:rpc#port = get( g:, "rpc#port", 55555 )

let g:rpc#loaded = 1
let g:rpc#socket_ready = v:null
let s:job = 0
let s:channel = 0
let s:ft_type = {
    \ "javascript": "application/javascript",
    \ "typescript": "application/typescript",
    \ "ant": "text/xml"
\ }

command! SrcLint call s:src('lint')
command! SrcCompress call s:src('compress')
command! SrcObfuscate call s:src('obfuscate')

command! BrowserPrint call s:browser_print()

func! s:OnExit(job_id, code, event) " {{{
    if s:channel
        call chanclose(s:channel)
        let s:channel = 0
    endif
endfunc " }}}

func! s:check_socket() " {{{
    let s:channel = sockconnect("tcp", g:rpc#hostname . ":" . g:rpc#port, {"rpc": v:true})

    if s:channel
        return v:true
    else
        silent! redraw!

        return v:false
    endif
endfunc " }}}

func! s:check_channel() " {{{

    " check channel
    if s:channel
        for channel in nvim_list_chans()

            " already connected, return
            if channel.id == s:channel | return | endif
        endfor

        let s:channel = 0
    endif

    " run job
    if !s:check_socket()
        echom "Starting softvisio cli"

        if has('win16') || has('win32') || has('win64')
            let s:job = jobstart( "softvisio-cli.cmd rpc", {"on_exit": function("s:OnExit")} )
        else
            let s:job = jobstart( "softvisio-cli rpc" )
        endif

        silent! redraw

        sleep 3
    endif

    if !s:channel
        let s:channel = sockconnect("tcp", g:rpc#hostname . ":" . g:rpc#port, {"rpc": v:true})

        " unable to connect
        if !s:channel
            echohl ErrorMsg
            echo "Failed to connect to softvisio cli"
            echohl None
        endif
    endif

endfunc " }}}

func! s:src(type) " {{{
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
        if ( l:path == "" ) | let l:path = "test" | endif

        " special case for makefiles
        if ( &ft == "make" )
            let l:path = fnamemodify( l:path, ":h" ) . "/Makefile"

        " add &ft as extension if mime type wasn't found and extension ne &ft
        elseif ( l:type == "" && &ft != "" && expand( "%:e" ) != &ft )
            let l:path .= "." . &ft
        endif

        let l:res = rpcrequest( s:channel, "lint", { "action": a:type, "path": l:path, "type": l:type, "buffer": l:buf } )

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

        if l:res.status >= 300
            echohl ErrorMsg
            echo a:type . ":  " . res.status_text
            echohl None
        elseif l:res.status >= 201
            echohl WarningMsg
            echo a:type . ":  " . res.status_text
            echohl None
        else
            echohl Comment
            echo a:type . ":  " . res.status_text
            echohl None
        endif
    endif

    return
endfunc " }}}

func! s:browser_print() " {{{
    let l:buf = join(getline(1,'$'), "\n")

    if l:buf == ''
        echohl Comment
        echo "Buffer is empty"
        echohl None

        return
    endif

    call s:check_channel()

    if s:channel
        let l:buf .= "\n"

        let l:res = rpcrequest(s:channel, "browserPrint", {"encoding": &encoding, "font": &gfn, "data": l:buf})
    endif

    return
endfunc " }}}
