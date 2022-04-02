" autocmd BufNewFile,BufRead *.html call s:detectEjs()

func! s:detectEjs()
    if search('<%') > 0
        set filetype=html-ejs
    endif

    return
endf
