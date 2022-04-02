if search('^\s*use\s\+Pcore\(;\|\s\)', 'wn') > 0

    " Pcore::Core keywords
    syn match perlStatementProc "\<\%(P\|Pcore\)\>"                                       " Pcore
    syn match perlStatementProc "\<\%(croak\|cluck\)\>"                                   " Pcore::Core::Excepions
    syn match perlStatementProc "\<\%(dump\)\>"                                           " Pcore::Core::Dump

    syntax match perlPcorePragma "\<\%(ansi\|class\|const\|dist\|embedded\|export\|forktmpl\|l10n\|res\|role\|sql\)\>" " contained

    " syn match perlPcoreDeclaration "\<\%(use\s\+Pcore\)\>" contains=perlPcorePragma
    " syn region perlPcoreDeclaration start="use Pcore" end=";" contains=perlPcorePragma

    " hi def link perlPcoreDeclaration perlStatement
    hi def link perlPcorePragma perlStatement

	syntax match perlStatementProc "\<\%(TO_BOOL\)\>"

    if search('^\s*use\s\+Pcore.*-class', 'wn') > 0
        syntax match perlStatementProc "\<\%(extends\|with\|has\|around\)\>"
    elseif search('^\s*use\s\+Pcore.*-role', 'wn') > 0
        syntax match perlStatementProc "\<\%(requires\|with\|has\|around\)\>"
    endif

    if search('^\s*use\s\+Pcore.*-const', 'wn') > 0
        syntax match perlStatementProc "\<\%(const\)\>"
    endif

    if search('^\s*use\s\+Pcore.*-l10n', 'wn') > 0
        syntax match perlStatementProc "\<\%(l10n\)\>"
    endif

    if search('^\s*use\s\+Pcore.*-res', 'wn') > 0
        syntax match perlStatementProc "\<\%(res\)\>"
    endif

    if search('^\s*use\s\+Pcore.*-ansi', 'wn') > 0
        syntax match perlPackageRef "$\(BLACK\|BLINK\|BLUE\|BOLD\|BRIGHT_BLACK\|BRIGHT_BLUE\|BRIGHT_CYAN\|BRIGHT_GREEN\|BRIGHT_MAGENTA\|BRIGHT_RED\|BRIGHT_WHITE\|BRIGHT_YELLOW\|CONCEALED\|CYAN\|DARK\|GREEN\|ITALIC\|MAGENTA\|ON_BLACK\|ON_BLUE\|ON_BRIGHT_BLACK\|ON_BRIGHT_BLUE\|ON_BRIGHT_CYAN\|ON_BRIGHT_GREEN\|ON_BRIGHT_MAGENTA\|ON_BRIGHT_RED\|ON_BRIGHT_WHITE\|ON_BRIGHT_YELLOW\|ON_CYAN\|ON_GREEN\|ON_MAGENTA\|ON_RED\|ON_WHITE\|ON_YELLOW\|RED\|RESET\|REVERSE\|UNDERLINE\|WHITE\|YELLOW\)"
    endif

    if search('^\s*use\s\+Pcore.*-sql', 'wn') > 0
        syntax match perlStatementProc "\<\%(SQL\|SET\|VALUES\|ON\|WHERE\|IN\|GROUP_BY\|HAVING\|ORDER_BY\|OFFSET\|LIMIT\)\>"
        syntax match perlStatementProc "\<\%(SQL_BYTEA\|SQL_JSON\|SQL_UUID\|SQL_TEXT\)\>"
    endif
endif
