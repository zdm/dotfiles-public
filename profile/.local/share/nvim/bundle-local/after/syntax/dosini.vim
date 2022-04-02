set foldmethod=expr
set foldexpr=DosINIFoldexpr(v:lnum)

function! DosINIFoldexpr (line)
    if getline(a:line)[0] == '' && getline(a:line + 1)[0] == '['
        return '0'
    elseif getline(a:line + 1)[0] == '['
        return '<1'
    elseif getline(a:line)[0] == '['
        return '>1'
    else
        return '='
    endif
endfunction
