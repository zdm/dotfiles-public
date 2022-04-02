if exists('g:loaded_unite_source_session') || $SUDO_USER != '' || v:version < 703
    finish
endif

let s:save_cpo = &cpo
set cpo&vim

let g:unite_source_session_enable_auto_save = get(g:, 'unite_source_session_enable_auto_save', 0)

if g:unite_source_session_enable_auto_save
    augroup plugin-unite-source-session
        autocmd!
        autocmd VimLeavePre * if v:this_session != '' | call unite#sources#session#_save('') | endif
    augroup END
endif

let g:loaded_unite_source_session = 1

let &cpo = s:save_cpo
unlet s:save_cpo
