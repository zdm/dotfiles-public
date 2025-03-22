let s:save_cpo = &cpo
set cpo&vim

" variables
call unite#util#set_default('g:unite_source_session_default_session_name', 'default')
call unite#util#set_default('g:unite_source_session_path', g:unite_data_directory . '/session')

function! unite#sources#session#define()
    return [ s:source, s:source_new ]
endfunction

function! unite#sources#session#_save(filename, ...)
    if unite#util#is_cmdwin()
        return
    endif

    if !isdirectory(g:unite_source_session_path)
        call mkdir(g:unite_source_session_path, 'p')
    endif

    let filename = s:get_session_path(a:filename)

    execute 'silent mksession!' filename
endfunction

function! unite#sources#session#_load(filename)
    if unite#util#is_cmdwin()
        return
    endif

    " save current session
    if v:this_session != '' | call unite#sources#session#_save('') | endif

    let filename = s:get_session_path(a:filename)

    try
        set eventignore=all
        " Delete all buffers.
        execute 'silent! 1,' . bufnr('$') . 'bwipeout!'
        let bufnr = bufnr('%')
        execute 'silent! source' filename
        execute 'silent! bwipeout!' bufnr
    finally
        set eventignore=
        doautoall BufRead
        doautoall FileType
        doautoall BufEnter
        doautoall BufWinEnter
        doautoall TabEnter
        doautoall SessionLoadPost
    endtry

    " refresh syntax for all tabs
    exec 'tabdo syn sync fromstart'
endfunction

function! unite#sources#session#_complete(arglead, cmdline, cursorpos)
    let sessions = split(glob(g:unite_source_session_path.'/*'), '\n')
    return filter(sessions, 'stridx(v:val, a:arglead) == 0')
endfunction

let s:source = {
\    'name' : 'session',
\    'description' : 'candidates from session list',
\    'syntax' : 'uniteSource__session',
\    'sorters' : ['sorter_ftime', 'sorter_reverse'],
\    'default_action' : 'load',
\    'alias_table' : { 'edit' : 'open' },
\    'action_table' : {},
\    'hooks' : {}
\}

function! s:source.gather_candidates(args, context)
    let sessions = split(glob(g:unite_source_session_path.'/*'), '\n')

    let candidates = []
    let min_len = 0

    for session in sessions
        if len(fnamemodify(session, ':t:r')) > min_len
            let min_len = len(fnamemodify(session, ':t:r'))
        endif
    endfor

    for session in sessions
        let current = ''
        if fnamemodify(v:this_session, ':t:r') == fnamemodify(session, ':t:r')
            let current = '@'
        endif

        let word = printf("%1S %-" . min_len . "S   [%s]", current, fnamemodify(session, ':t:r'), strftime("%a, %d %b %Y %H:%M:%S", getftime(session)))

        let candidate = {
\    'word' : word,
\    'kind' : 'file',
\    'action__path' : session,
\    'action__directory' : unite#util#path2directory(session)
\}
        call add(candidates, candidate)
    endfor

    return candidates
endfunction

function! s:source.hooks.on_syntax(args, context)
    syntax match uniteSource__session_current /%/ contained containedin=uniteSource__session
    highlight default link uniteSource__session_current PreProc

    syntax match uniteSource__session_name /[^%\[]\+/ contained containedin=uniteSource__session
    highlight default link uniteSource__session_name Statement

    syntax match uniteSource__session_date /\[.*\]/ contained containedin=uniteSource__session
    highlight default link uniteSource__session_date Function
endfunction

" actions
let s:source.action_table.load = {
\    'description' : 'load this session',
\}

function! s:source.action_table.load.func(candidate)
    call unite#sources#session#_load(a:candidate.action__path)
endfunction

let s:source.action_table.delete = {
\    'description' : 'delete from session list',
\    'is_invalidate_cache' : 1,
\    'is_quit' : 0,
\    'is_selectable' : 1,
\}

function! s:source.action_table.delete.func(candidates)
    for candidate in a:candidates
        if input('Really delete session file: ' . candidate.action__path . '? ') =~? 'y\%[es]'
            call delete(candidate.action__path)
        endif
    endfor
endfunction

let s:source.action_table.rename = {
\    'description' : 'rename session name',
\    'is_invalidate_cache' : 1,
\    'is_quit' : 0,
\    'is_selectable' : 1,
\}

function! s:source.action_table.rename.func(candidates)
    for candidate in a:candidates
        let session_name = input(printf('New session name: %s -> ', candidate.word), candidate.word)
        if session_name != '' && session_name !=# candidate.word
            call rename(candidate.action__path, s:get_session_path(session_name))
        endif
    endfor
endfunction

let s:source.action_table.save = {
\    'description' : 'save current session as candidate',
\    'is_invalidate_cache' : 1,
\    'is_quit' : 0,
\    'is_selectable' : 1,
\}

function! s:source.action_table.save.func(candidates)
    for candidate in a:candidates
        if input('Really save the current session as: ' . candidate.word . '? ') =~? 'y\%[es]'
            call unite#sources#session#_save(candidate.word)
        endif
    endfor
endfunction

let s:source_new = {
\    'name' : 'session/new',
\    'description' : 'Save session as ...',
\    'syntax' : 'uniteSource__session',
\    'default_action' : 'save',
\    'action_table' : {},
\    'hooks' : {},
\}

function! s:source_new.change_candidates(args, context)
    return [{ 'word': '', 'abbr': 'create new session', 'kind' : 'common' }]
endfunction

function! s:source_new.hooks.on_syntax(args, context)
    syntax match uniteSource__session_new /create new session/ contained containedin=uniteSource__session
    highlight default link uniteSource__session_new None
endfunction

let s:source_new.action_table.save = s:source.action_table.save

function! s:source_new.action_table.save.func(candidates)
    let name = input('Save session as: ')

    if name != ''
        close
        call unite#sources#session#_save(name)
        redraw | echohl Comment | echo 'Session was saved as: "' . name . '"' | echohl None
    else
        redraw | echohl WarningMsg | echo 'Session creation was cancelled' | echohl None
    endif
endfunction

function! s:get_session_path(filename)
    let filename = a:filename
    if filename == ''
        let filename = v:this_session
    endif

    if filename == ''
        let filename = g:unite_source_session_default_session_name
    endif

    let filename = unite#util#substitute_path_separator(filename)

    if filename !~ '.vim$'
        let filename .= '.vim'
    endif

    if filename !~ '^\%(/\|\a\+:/\)'
        " Relative path.
        let filename = g:unite_source_session_path . '/' . filename
    endif

    return filename
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo
