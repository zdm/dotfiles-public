if exists("g:helper#loaded")
    finish
endif
let g:helper#loaded = 1

let g:unite_source_menu_menus.helper = {}
let g:unite_source_menu_menus.helper.command_candidates = [
\    ["update plugins                       - :silent! Lazy sync", "silent! Lazy sync"],
\    ["set ft=javascript                    - :set ft=javascript", "set ft=javascript"],
\    ["set ft=json                          - :set ft=json", "set ft=json"],
\    ["delete all hidden buffers            - call helper#cleanupBuffers()", "call helper#cleanupBuffers()"],
\    ["edit snippets                        - :VsnipOpen", "VsnipOpen"],
\    ["open buffer in the browser           - :S browser", "S browser"],
\    ["spellchecker on                      - :setlocal spell spelllang=ru_yo,en_us", "setlocal spell spelllang=ru_yo,en_us"],
\    ["spellchecker off                     - :setlocal nospell", "setlocal nospell"],
\    ["set linendings to UNIX format        - :setlocal ff=unix", "setlocal ff=unix"],
\    ["matrix screensaver                   - :Matrix", "Matrix"]
\]
