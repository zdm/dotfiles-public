syn keyword commentError contained FIXME BUG ERROR FIXME: BUG: ERROR:
syn keyword commentWarning contained HACK WARNING WARN FIX HACK: WARNING: WARN: FIX:
syn keyword commentNote contained NOTE INFO DOCS PERF TEST NOTE: INFO: DOCS: PERF: TEST:
syn keyword commentTodo contained TODO WIP XXX TODO: WIP: XXX:

syn match dosbatchRemComment "^rem\($\|\s.*$\)"lc=3 contains=commentError,commentWarning,commentNote,commentTodo,dosbatchSpecialChar,@dosbatchNumber,dosbatchVariable,dosbatchArgument,@Spell

syn match dosbatchRemComment "^@rem\($\|\s.*$\)"lc=4 contains=commentError,commentWarning,commentNote,commentTodo,@dosbatchNumber,dosbatchVariable,dosbatchArgument,@Spell

syn match dosbatchRemComment "\srem\($\|\s.*$\)"lc=4 contains=commentError,commentWarning,commentNote,commentTodo,dosbatchSpecialChar,@dosbatchNumber,dosbatchVariable,dosbatchArgument,@Spell

syn match dosbatchRemComment "\s@rem\($\|\s.*$\)"lc=5 contains=commentError,commentWarning,commentNote,commentTodo,@dosbatchNumber,dosbatchVariable,dosbatchArgument,@Spell

syn match dosbatchColonComment "\s*:\s*:.*$" contains=commentError,commentWarning,commentNote,commentTodo,dosbatchSpecialChar,@dosbatchNumber,dosbatchVariable,dosbatchArgument,@Spell

hi link commentError @comment.error
hi link commentWarning @comment.warning
hi link commentNote @comment.note
hi link commentTodo @comment.todo
