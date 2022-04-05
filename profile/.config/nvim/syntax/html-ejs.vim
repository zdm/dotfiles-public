if exists("b:current_syntax")
    finish
endif

runtime! syntax/html.vim
unlet b:current_syntax

runtime! syntax/ejs.vim
unlet b:current_syntax

let b:current_syntax = "html-ejs"
