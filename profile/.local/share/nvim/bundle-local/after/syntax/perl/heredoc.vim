let s:bcs = b:current_syntax

unlet b:current_syntax
syntax include @SQL syntax/sql.vim

unlet b:current_syntax
syntax include @JS syntax/javascript.vim

" NOTE also loads C syntax
unlet b:current_syntax
syntax include @CPP syntax/cpp.vim

" NOTE must be loadede after CPP
" unlet b:current_syntax
" syntax include @CPP syntax/c.vim

let b:current_syntax = s:bcs

if get(g:, 'perl_fold', 0)

    " SQL
    syntax region perlHereDocSQL matchgroup=perlStringStartEnd start=/<<'SQL'/        end=/^SQL$/ contains=@SQL               fold extend
    syntax region perlHereDocSQL matchgroup=perlStringStartEnd start=/<<\("\?\)SQL\1/ end=/^SQL$/ contains=@perlInterpDQ,@SQL fold extend

    syntax region perlHereDocSQL matchgroup=perlStringStartEnd start=/<<\~'SQL'/        end=/^\s*SQL$/ contains=@SQL               fold extend
    syntax region perlHereDocSQL matchgroup=perlStringStartEnd start=/<<\~\("\?\)SQL\1/ end=/^\s*SQL$/ contains=@perlInterpDQ,@SQL fold extend

    " JS
    syntax region perlHereDocJS  matchgroup=perlStringStartEnd start=/<<'JS'/         end=/^JS$/ contains=@JS                fold extend
    syntax region perlHereDocJS  matchgroup=perlStringStartEnd start=/<<\("\?\)JS\1/  end=/^JS$/ contains=@perlInterpDQ,@JS  fold extend

    syntax region perlHereDocJS  matchgroup=perlStringStartEnd start=/<<\~'JS'/         end=/^\s*JS$/ contains=@JS                fold extend
    syntax region perlHereDocJS  matchgroup=perlStringStartEnd start=/<<\~\("\?\)JS\1/  end=/^\s*JS$/ contains=@perlInterpDQ,@JS  fold extend

    " C
    syntax region perlHereDocC   matchgroup=perlStringStartEnd start=/<<'C'/          end=/^C$/ contains=@CPP                 fold extend
    syntax region perlHereDocC   matchgroup=perlStringStartEnd start=/<<\("\?\)C\1/   end=/^C$/ contains=@perlInterpDQ,@CPP   fold extend

    syntax region perlHereDocC   matchgroup=perlStringStartEnd start=/<<\~'C'/          end=/^\s*C$/ contains=@CPP                fold extend
    syntax region perlHereDocC   matchgroup=perlStringStartEnd start=/<<\~\("\?\)C\1/   end=/^\s*C$/ contains=@perlInterpDQ,@CPP  fold extend

    " CPP
    syntax region perlHereDocCPP matchgroup=perlStringStartEnd start=/<<'CPP'/        end=/^CPP$/ contains=@CPP               fold extend
    syntax region perlHereDocCPP matchgroup=perlStringStartEnd start=/<<\("\?\)CPP\1/ end=/^CPP$/ contains=@perlInterpDQ,@CPP fold extend

    syntax region perlHereDocCPP matchgroup=perlStringStartEnd start=/<<\~'CPP'/        end=/^\s*CPP$/ contains=@CPP               fold extend
    syntax region perlHereDocCPP matchgroup=perlStringStartEnd start=/<<\~\("\?\)CPP\1/ end=/^\s*CPP$/ contains=@perlInterpDQ,@CPP fold extend
else

    " SQL
    syntax region perlHereDocSQL matchgroup=perlStringStartEnd start=/<<'SQL'/        end=/^SQL$/ contains=@SQL
    syntax region perlHereDocSQL matchgroup=perlStringStartEnd start=/<<\("\?\)SQL\1/ end=/^SQL$/ contains=@perlInterpDQ,@SQL

    syntax region perlHereDocSQL matchgroup=perlStringStartEnd start=/<<\~'SQL'/        end=/^\s*SQL$/ contains=@SQL
    syntax region perlHereDocSQL matchgroup=perlStringStartEnd start=/<<\~\("\?\)SQL\1/ end=/^\s*SQL$/ contains=@perlInterpDQ,@SQL

    " JS
    syntax region perlHereDocJS  matchgroup=perlStringStartEnd start=/<<'JS'/         end=/^JS$/ contains=@JS
    syntax region perlHereDocJS  matchgroup=perlStringStartEnd start=/<<\("\?\)JS\1/  end=/^JS$/ contains=@perlInterpDQ,@JS

    syntax region perlHereDocJS  matchgroup=perlStringStartEnd start=/<<\~'JS'/         end=/^\s*JS$/ contains=@JS
    syntax region perlHereDocJS  matchgroup=perlStringStartEnd start=/<<\~\("\?\)JS\1/  end=/^\s*JS$/ contains=@perlInterpDQ,@JS

    " C
    syntax region perlHereDocC   matchgroup=perlStringStartEnd start=/<<'C'/          end=/^C$/ contains=@C
    syntax region perlHereDocC   matchgroup=perlStringStartEnd start=/<<\("\?\)C\1/   end=/^C$/ contains=@perlInterpDQ,@C

    syntax region perlHereDocC   matchgroup=perlStringStartEnd start=/<<\~'C'/          end=/^\s*C$/ contains=@C
    syntax region perlHereDocC   matchgroup=perlStringStartEnd start=/<<\~\("\?\)C\1/   end=/^\s*C$/ contains=@perlInterpDQ,@C

    " CPP
    syntax region perlHereDocCPP matchgroup=perlStringStartEnd start=/<<'CPP'/        end=/^CPP$/ contains=@CPP
    syntax region perlHereDocCPP matchgroup=perlStringStartEnd start=/<<\("\?\)CPP\1/ end=/^CPP$/ contains=@perlInterpDQ,@CPP

    syntax region perlHereDocCPP matchgroup=perlStringStartEnd start=/<<\~'CPP'/        end=/^\s*CPP$/ contains=@CPP
    syntax region perlHereDocCPP matchgroup=perlStringStartEnd start=/<<\~\("\?\)CPP\1/ end=/^\s*CPP$/ contains=@perlInterpDQ,@CPP
endif

" runtime! syntax/tt2.vim
" unlet b:current_syntax
" syntax include @TT2 syntax/tt2.vim
"
" if get(g:, 'perl_fold', 0)
"     syntax region perlHereDocTT2 matchgroup=perlStringStartEnd start=+<<\s*'\z(\%(END_\)\=TT2\)'+ end='^\z1$' contains=@TT2               fold extend
"     syntax region perlHereDocTT2 matchgroup=perlStringStartEnd start='<<\s*"\z(\%(END_\)\=TT2\)"' end='^\z1$' contains=@perlInterpDQ,@TT2 fold extend
"     syntax region perlHereDocTT2 matchgroup=perlStringStartEnd start='<<\s*\z(\%(END_\)\=TT2\)'   end='^\z1$' contains=@perlInterpDQ,@TT2 fold extend
" else
"     syntax region perlHereDocTT2 matchgroup=perlStringStartEnd start=+<<\s*'\z(\%(END_\)\=TT2\)'+ end='^\z1$' contains=@TT2
"     syntax region perlHereDocTT2 matchgroup=perlStringStartEnd start='<<\s*"\z(\%(END_\)\=TT2\)"' end='^\z1$' contains=@perlInterpDQ,@TT2
"     syntax region perlHereDocTT2 matchgroup=perlStringStartEnd start='<<\s*\z(\%(END_\)\=TT2\)'   end='^\z1$' contains=@perlInterpDQ,@TT2
" endif
"
" " HTML
" runtime! syntax/html.vim
" unlet b:current_syntax
" syntax include @HTML syntax/html.vim
"
" if get(g:, 'perl_fold', 0)
"     syntax region perlHereDocHTML matchgroup=perlStringStartEnd start=+<<\s*'\z(\%(END_\)\=HTML\)'+ end='^\z1$' contains=@HTML               fold extend
"     syntax region perlHereDocHTML matchgroup=perlStringStartEnd start='<<\s*"\z(\%(END_\)\=HTML\)"' end='^\z1$' contains=@perlInterpDQ,@HTML fold extend
"     syntax region perlHereDocHTML matchgroup=perlStringStartEnd start='<<\s*\z(\%(END_\)\=HTML\)'   end='^\z1$' contains=@perlInterpDQ,@HTML fold extend
" else
"     syntax region perlHereDocHTML matchgroup=perlStringStartEnd start=+<<\s*'\z(\%(END_\)\=HTML\)'+ end='^\z1$' contains=@HTML
"     syntax region perlHereDocHTML matchgroup=perlStringStartEnd start='<<\s*"\z(\%(END_\)\=HTML\)"' end='^\z1$' contains=@perlInterpDQ,@HTML
"     syntax region perlHereDocHTML matchgroup=perlStringStartEnd start='<<\s*\z(\%(END_\)\=HTML\)'   end='^\z1$' contains=@perlInterpDQ,@HTML
" endif
"
" " TT2HTML
" runtime! syntax/tt2html.vim
" unlet b:current_syntax
" syntax include @TT2HTML syntax/tt2html.vim
"
" if get(g:, 'perl_fold', 0)
"     syntax region perlHereDocTT2HTML matchgroup=perlStringStartEnd start=+<<\s*'\z(\%(END_\)\=TT2HTML\)'+ end='^\z1$' contains=@TT2HTML               fold extend
"     syntax region perlHereDocTT2HTML matchgroup=perlStringStartEnd start='<<\s*"\z(\%(END_\)\=TT2HTML\)"' end='^\z1$' contains=@perlInterpDQ,@TT2HTML fold extend
"     syntax region perlHereDocTT2HTML matchgroup=perlStringStartEnd start='<<\s*\z(\%(END_\)\=TT2HTML\)'   end='^\z1$' contains=@perlInterpDQ,@TT2HTML fold extend
" else
"     syntax region perlHereDocTT2HTML matchgroup=perlStringStartEnd start=+<<\s*'\z(\%(END_\)\=TT2HTML\)'+ end='^\z1$' contains=@TT2HTML
"     syntax region perlHereDocTT2HTML matchgroup=perlStringStartEnd start='<<\s*"\z(\%(END_\)\=TT2HTML\)"' end='^\z1$' contains=@perlInterpDQ,@TT2HTML
"     syntax region perlHereDocTT2HTML matchgroup=perlStringStartEnd start='<<\s*\z(\%(END_\)\=TT2HTML\)'   end='^\z1$' contains=@perlInterpDQ,@TT2HTML
" endif

" TT2JS
" runtime! syntax/tt2js.vim
" unlet b:current_syntax
" syntax include @TT2JS syntax/tt2js.vim
"
" if get(g:, 'perl_fold', 0)
"     syntax region perlHereDocTT2JS matchgroup=perlStringStartEnd start=+<<\s*'\z(\%(END_\)\=TT2JS\)'+ end='^\z1$' contains=@TT2JS               fold extend
"     syntax region perlHereDocTT2JS matchgroup=perlStringStartEnd start='<<\s*"\z(\%(END_\)\=TT2JS\)"' end='^\z1$' contains=@perlInterpDQ,@TT2JS fold extend
"     syntax region perlHereDocTT2JS matchgroup=perlStringStartEnd start='<<\s*\z(\%(END_\)\=TT2JS\)'   end='^\z1$' contains=@perlInterpDQ,@TT2JS fold extend
" else
"     syntax region perlHereDocTT2JS matchgroup=perlStringStartEnd start=+<<\s*'\z(\%(END_\)\=TT2JS\)'+ end='^\z1$' contains=@TT2JS
"     syntax region perlHereDocTT2JS matchgroup=perlStringStartEnd start='<<\s*"\z(\%(END_\)\=TT2JS\)"' end='^\z1$' contains=@perlInterpDQ,@TT2JS
"     syntax region perlHereDocTT2JS matchgroup=perlStringStartEnd start='<<\s*\z(\%(END_\)\=TT2JS\)'   end='^\z1$' contains=@perlInterpDQ,@TT2JS
" endif

" " nginx
" runtime! syntax/nginx.vim
" unlet b:current_syntax
" syntax include @NGINX syntax/nginx.vim
"
" if get(g:, 'perl_fold', 0)
"     syntax region perlHereDocNGINX matchgroup=perlStringStartEnd start=+<<\s*'\z(\%(END_\)\=NGINX\)'+ end='^\z1$' contains=@NGINX               fold extend
"     syntax region perlHereDocNGINX matchgroup=perlStringStartEnd start='<<\s*"\z(\%(END_\)\=NGINX\)"' end='^\z1$' contains=@perlInterpDQ,@NGINX fold extend
"     syntax region perlHereDocNGINX matchgroup=perlStringStartEnd start='<<\s*\z(\%(END_\)\=NGINX\)'   end='^\z1$' contains=@perlInterpDQ,@NGINX fold extend
" else
"     syntax region perlHereDocNGINX matchgroup=perlStringStartEnd start=+<<\s*'\z(\%(END_\)\=NGINX\)'+ end='^\z1$' contains=@NGINX
"     syntax region perlHereDocNGINX matchgroup=perlStringStartEnd start='<<\s*"\z(\%(END_\)\=NGINX\)"' end='^\z1$' contains=@perlInterpDQ,@NGINX
"     syntax region perlHereDocNGINX matchgroup=perlStringStartEnd start='<<\s*\z(\%(END_\)\=NGINX\)'   end='^\z1$' contains=@perlInterpDQ,@NGINX
" endif

" " TT2NGINX
" runtime! syntax/tt2nginx.vim
" unlet b:current_syntax
" syntax include @TT2NGINX syntax/tt2nginx.vim
"
" if get(g:, 'perl_fold', 0)
"     syntax region perlHereDocTT2NGINX matchgroup=perlStringStartEnd start=+<<\s*'\z(\%(END_\)\=TT2NGINX\)'+ end='^\z1$' contains=@TT2NGINX               fold extend
"     syntax region perlHereDocTT2NGINX matchgroup=perlStringStartEnd start='<<\s*"\z(\%(END_\)\=TT2NGINX\)"' end='^\z1$' contains=@perlInterpDQ,@TT2NGINX fold extend
"     syntax region perlHereDocTT2NGINX matchgroup=perlStringStartEnd start='<<\s*\z(\%(END_\)\=TT2NGINX\)'   end='^\z1$' contains=@perlInterpDQ,@TT2NGINX fold extend
" else
"     syntax region perlHereDocTT2NGINX matchgroup=perlStringStartEnd start=+<<\s*'\z(\%(END_\)\=TT2NGINX\)'+ end='^\z1$' contains=@TT2NGINX
"     syntax region perlHereDocTT2NGINX matchgroup=perlStringStartEnd start='<<\s*"\z(\%(END_\)\=TT2NGINX\)"' end='^\z1$' contains=@perlInterpDQ,@TT2NGINX
"     syntax region perlHereDocTT2NGINX matchgroup=perlStringStartEnd start='<<\s*\z(\%(END_\)\=TT2NGINX\)'   end='^\z1$' contains=@perlInterpDQ,@TT2NGINX
" endif
"
" " SH
" runtime! syntax/sh.vim
" unlet b:current_syntax
" syntax include @SH syntax/sh.vim
"
" if get(g:, 'perl_fold', 0)
"     syntax region perlHereDocSH matchgroup=perlStringStartEnd start=+<<\s*'\z(\%(END_\)\=SH\)'+ end='^\z1$' contains=@SH               fold extend
"     syntax region perlHereDocSH matchgroup=perlStringStartEnd start='<<\s*"\z(\%(END_\)\=SH\)"' end='^\z1$' contains=@perlInterpDQ,@SH fold extend
"     syntax region perlHereDocSH matchgroup=perlStringStartEnd start='<<\s*\z(\%(END_\)\=SH\)'   end='^\z1$' contains=@perlInterpDQ,@SH fold extend
" else
"     syntax region perlHereDocSH matchgroup=perlStringStartEnd start=+<<\s*'\z(\%(END_\)\=SH\)'+ end='^\z1$' contains=@SH
"     syntax region perlHereDocSH matchgroup=perlStringStartEnd start='<<\s*"\z(\%(END_\)\=SH\)"' end='^\z1$' contains=@perlInterpDQ,@SH
"     syntax region perlHereDocSH matchgroup=perlStringStartEnd start='<<\s*\z(\%(END_\)\=SH\)'   end='^\z1$' contains=@perlInterpDQ,@SH
" endif
"
" " TT2SH
" runtime! syntax/tt2nsh.vim
" unlet b:current_syntax
" syntax include @TT2SH syntax/tt2sh.vim
"
" if get(g:, 'perl_fold', 0)
"     syntax region perlHereDocTT2SH matchgroup=perlStringStartEnd start=+<<\s*'\z(\%(END_\)\=TT2SH\)'+ end='^\z1$' contains=@TT2SH               fold extend
"     syntax region perlHereDocTT2SH matchgroup=perlStringStartEnd start='<<\s*"\z(\%(END_\)\=TT2SH\)"' end='^\z1$' contains=@perlInterpDQ,@TT2SH fold extend
"     syntax region perlHereDocTT2SH matchgroup=perlStringStartEnd start='<<\s*\z(\%(END_\)\=TT2SH\)'   end='^\z1$' contains=@perlInterpDQ,@TT2SH fold extend
" else
"     syntax region perlHereDocTT2SH matchgroup=perlStringStartEnd start=+<<\s*'\z(\%(END_\)\=TT2SH\)'+ end='^\z1$' contains=@TT2SH
"     syntax region perlHereDocTT2SH matchgroup=perlStringStartEnd start='<<\s*"\z(\%(END_\)\=TT2SH\)"' end='^\z1$' contains=@perlInterpDQ,@TT2SH
"     syntax region perlHereDocTT2SH matchgroup=perlStringStartEnd start='<<\s*\z(\%(END_\)\=TT2SH\)'   end='^\z1$' contains=@perlInterpDQ,@TT2SH
" endif
