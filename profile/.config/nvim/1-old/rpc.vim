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
    \ "json": "application/json",
    \ "sh": "application/x-sh",
    \ "ant": "text/xml"
\ }

command! Lint call s:lint_file( 'lint' )
command! LintFormat call s:lint_file( 'format' )
command! LintCompress call s:lint_file( 'compress' )
command! LintObfuscate call s:lint_file( 'obfuscate' )

command! BrowserPrint call s:browser_print()

func! s:check_socket ()

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
endfunc

func! s:check_channel ()

    " start LSP server
    if !s:check_socket()
        echom "Starting LSP server"

        if has( "win32" )
            let s:job = jobstart( "softvisio-cli.cmd lsp start" )
        else
            let s:job = jobstart( "softvisio-cli lsp start" )
        endif

        sleep 3
    endif

    let n = 10

    while n > 0
        let n -= 1

        if s:check_socket()
            break
        else
            echom "Connecting to the LSP server"

            sleep 1
        endif
    endwhile

    " unable to connect
    if s:channel
        silent! redraw
    else
        echohl ErrorMsg
        echo "Failed to connect to the LSP server"
        echohl None
    endif

endfunc

func! s:lint_file ( type )
    let l:eol = { "unix": "\n", "dos": "\r\n", "mac": "\r" }[ &fileformat ]
    let l:buf = join( getline( 1, '$' ), l:eol )

    silent! redraw

    if l:buf == ''
        echohl Comment
        echo "Buffer is empty"
        echohl None

        return
    endif

    call s:check_channel()

    if s:channel

        " insert final newline
        if !exists( "b:editorconfig" ) || type( b:editorconfig ) != v:t_dict || b:editorconfig.insert_final_newline == "true"
            let l:buf .= l:eol
        endif

        echo a:type . ":  run source filter..."

        let l:type = get( s:ft_type, &ft )
        let l:path = expand( '%:p' )

        if ( l:type == v:null ) | let l:type = "" | endif
        if ( l:path == "" ) | let l:path = "no-name" | endif

        " special case for makefiles
        " if ( &ft == "make" )
        "     let l:path = fnamemodify( l:path, ":h" ) . "/Makefile"

        " add &ft as extension if mime type wasn't found and extension ne &ft
        " elseif ( l:type == "" && &ft != "" && expand( "%:e" ) != &ft )
        "     let l:path .= "." . &ft
        " endif

        let l:res = rpcrequest( s:channel, "lint-file", { "action": a:type, "cwd": getcwd(), "path": l:path, "type": l:type, "buffer": l:buf } )

        if l:res.meta.isModified
            let l:res.data = substitute( l:res.data, '\r\n\?', "\n", "g" )

            let l:cursor_pos = getpos( "." )
            let l:syntax = getbufvar( "%", "&syntax" ) == "on"
            let l:foldmethod = getbufvar( "%", "&foldmethod" )

            if l:syntax
                setlocal syntax=off
            endif

            setlocal foldmethod=manual

            %delete
            put =l:res.data
            1delete 1

            " refresh treesitter, if used
lua << EOF
            if require( "utils" ).hasTreesitter() then
                require( "utils" ).parseTreesitter()
            end
EOF

            " refresh syntax, if used
            if l:syntax
                setlocal syntax=on
                syn sync fromstart
            endif

            call setpos( ".", l:cursor_pos )

            " open fold under the cursor
            exec( "setlocal foldmethod=" . l:foldmethod )
            normal zM
            normal zv

            " center cursor on the screen
            normal zz
        endif

        silent! redraw

        call v:lua.require'utils'.setDiagnostic( 0, l:res.meta.diagnostic )

        " parsing error
        if l:res.meta.parsingError
            echohl ErrorMsg
            echo a:type . ": " . l:res.status_text
            echohl None

lua << EOF
            require( "trouble" ).open( "diagnostics" )
            require( "trouble" ).focus()
EOF

        " errors
        elseif l:res.meta.hasErrors
            echohl ErrorMsg
            echo a:type . ": " . l:res.status_text
            echohl None

        " warnings
        elseif l:res.meta.hasWarnings
            echohl WarningMsg
            echo a:type . ": " . l:res.status_text
            echohl None

        " ok
        else
            echohl Comment
            echo a:type . ": " . l:res.status_text
            echohl None
        endif
    endif

    return
endfunc

func! s:browser_print ()
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
endfunc
