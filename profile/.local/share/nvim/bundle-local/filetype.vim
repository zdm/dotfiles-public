if exists("did_load_filetypes_userafter")
    finish
endif

let did_load_filetypes_userafter=1

augroup filetypedetect

    " perl
    au BufNewFile,BufRead *.t                          setf perl
    au BufNewFile,BufRead *.perl                       setf perl
    au BufNewFile,BufRead cpanfile                     setf perl

    " nginx
    au BufRead,BufNewFile nginx.conf                   setf nginx
    au BufNewFile,BufRead *.nginx.conf                 setf nginx
    au BufRead,BufNewFile */etc/nginx/*                setf nginx
augroup end
