if exists("g:helper#loaded")
    finish
endif
let g:helper#loaded = 1

command! DeinUpdate call s:dein_update()

function! s:dein_update()
    call dein#update()
    Unite -log -wrap dein/log:!
endfunction

let g:unite_source_menu_menus.helper = {}
let g:unite_source_menu_menus.helper.command_candidates = [
\    ["update bundles                       - :silent! DeinUpdate", "silent! DeinUpdate"],
\    ["set ft=javascript                    - :set ft=javascript", "set ft=javascript"],
\    ["delete all hidden buffers            - call helper#cleanupBuffers()", "call helper#cleanupBuffers()"],
\    ["edit snippets                        - :VsnipOpen", "VsnipOpen"],
\    ["browser print                        - :BrowserPrint", "BrowserPrint"],
\    ["spellchecker on                      - :setlocal spell spelllang=ru_yo,en_us", "setlocal spell spelllang=ru_yo,en_us"],
\    ["spellchecker off                     - :setlocal nospell", "setlocal nospell"],
\    ["set linendings to UNIX format        - :setlocal ff=unix", "setlocal ff=unix"],
\    ["matrix screensaver                   - :Matrix", "Matrix"]
\]
