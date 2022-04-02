if exists("b:did_POD_ftplugin")
	finish
endif

let b:did_POD_ftplugin = 1

" add ':' to the keyword characters<Esc>
" tokens like 'File::Find' are recognized as one keyword
setlocal iskeyword+=:
