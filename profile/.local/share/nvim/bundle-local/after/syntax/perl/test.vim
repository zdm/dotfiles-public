if search("^use Test::More", "wn") > 0
    syntax match perlStatementProc "\<\%(ok\|use_ok\|require_ok\|is\|isnt\|like\|unlike\|is_deeply\|cmp_ok\|skip\|todo\|todo_skip\|pass\|fail\|eq_array\|eq_hash\|eq_set\|plan\|done_testing\|can_ok\|isa_ok\|new_ok\|diag\|note\|explain\|subtest\|BAIL_OUT\)\>"
endif

if search("^use Test::Deep", "wn") > 0
    " EXPORT_OK
    syntax match perlStatementProc "\<\%(descend|render_stack|class_base|cmp_details|deep_diag\)\>"

    " EXPORT_TAGS v0
    syntax match perlStatementProc "\<\%(Isa\|blessed\|obj_isa\|all\|any\|array\|array_each\|arrayelementsonly\|arraylength\|arraylengthonly\|bag\|bool\|cmp_bag\|cmp_deeply\|cmp_methods\|cmp_set\|code\|eq_deeply\|hash\|hash_each\|hashkeys\|hashkeysonly\|ignore\|isa\|listmethods\|methods\|noclass\|noneof\|num\|re\|reftype\|regexpmatches\|regexponly\|regexpref\|regexprefonly\|scalarrefonly\|scalref\|set\|shallow\|str\|subbagof\|subhashof\|subsetof\|superbagof\|superhashof\|supersetof\|useclass\)\>"
endif
