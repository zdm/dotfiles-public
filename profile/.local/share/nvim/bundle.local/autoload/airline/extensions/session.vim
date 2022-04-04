function! airline#extensions#session#init(ext)
    " uncomment this lines if we use AirlineInit() in vimrc
    " call airline#parts#define_function('session', 'airline#extensions#session#getSession')
    " call airline#parts#define_accent('session', 'bold')

    " comment this lines if we use AirlineInit() in vimrc
    call a:ext.add_statusline_func('airline#extensions#session#apply')
endf

function! airline#extensions#session#apply(...)
    let w:airline_section_x = get(w:, 'airline_section_x', g:airline_section_x)
    let w:airline_section_x = '%#__accent_bold#' . '%{airline#extensions#session#getSession()}' . '%#__restore__#' . g:airline_symbols.space . w:airline_section_x
endf

function! airline#extensions#session#getSession()
    if get(w:, 'airline_active', 0)
        if v:this_session != ''
            return '@[' . fnamemodify(v:this_session, ':t:r') . ']'
        else
            return '@[none]'
        endif
    endif
    return ''
endf
