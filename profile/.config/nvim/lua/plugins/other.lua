return {
    {
        "mbbill/undotree",
        init = function ()
            vim.g.undotree_WindowLayout = 2
            vim.g.undotree_SplitWidth = 40
            vim.g.undotree_SetFocusWhenToggle = 1
            vim.g.undotree_DiffAutoOpen = 0
        end,
        config = function ()
            vim.keymap.set( { "n", "i", "v" }, "<F10>", function ()
                vim.cmd( "UndotreeToggle" )
            end, { noremap = true, silent = true } )
        end
    },
    {
        "powerman/vim-plugin-viewdoc",
        init = function ()
            vim.g.viewdoc_openempty = 1

            -- if !exists( "g:no_plugin_abbrev" ) && !exists( "g:no_viewdoc_abbrev" )
            --     cnoreabbrev <expr> h  getcmdtype() == ":" && getcmdline() == "h"  ? "ViewDocHelp"  : "h"
            --     cnoreabbrev <expr> h! getcmdtype() == ":" && getcmdline() == "h!" ? "ViewDocHelp"  : "h!"

            --     cnoreabbrev <expr> pd  getcmdtype() == ":" && getcmdline() == "pd"  ? "ViewDocPerl"  : "pd"
            --     cnoreabbrev <expr> pd! getcmdtype() == ":" && getcmdline() == "pd!" ? "ViewDocPerl"  : "pd!"
            -- endif
        end
    },
    {
        "yggdroot/indentline",
        init = function ()
            vim.g.indentLine_enabled = 1
            -- vim.g.indentLine_char = "│"
            -- vim.g.indentLine_showFirstIndentLevel = 1
            -- vim.g.indentLine_fileType = { "pl", "pm", "perl", "js" }
            vim.g.indentLine_fileTypeExclude = { "json", "markdown" }
            vim.g.indentLine_faster = 1
        end,
        config = function ()
            vim.keymap.set( { "n", "i", "v" }, "<Leader>ii", function ()
                vim.cmd( "IndentLinesToggle" )
            end, { noremap = true, silent = true } )
        end
    },
    { "uguu-org/vim-matrix-screensaver" },
    { "vim-scripts/dirdiff.vim" },
    { "zhimsel/vim-stay" },
    {
        "lyokha/vim-xkbswitch",
        dependencies = {
            "dexp/xkb-switch-win"
        },
        init = function ()
            vim.g.XkbSwitchEnabled = 1
            vim.g.XkbSwitchIMappings = { "ru" }
            vim.g.XkbSwitchIMappingsSkipFt = { "tex" }
            vim.g.XkbSwitchNLayout = "US"
            vim.g.XkbSwitchILayout = "US"

            if vim.fn.has( "win64" ) == 1 then
                vim.g.XkbSwitchLib = vim.fn.stdpath( "data" ) .. "/lazy/xkb-switch-win/bin/libxkbswitch64.dll"
            elseif vim.fn.has( "win32" ) == 1 then
                vim.g.XkbSwitchLib = vim.fn.stdpath( "data" ) .. "/lazy/xkb-switch-win/bin/libxkbswitch32.dll"
            else
                vim.g.XkbSwitchLib = ""
            end
        end
    },

    -- git
    { "tpope/vim-fugitive" },
    {
        "mhinz/vim-signify",
        init = function ()
            vim.g.signify_vcs_list = { "git" }
            vim.g.signify_realtime = 1
        end,
    },
    {
        "lewis6991/gitsigns.nvim",
        enabled = false,
        config = function ()
            require( "gitsigns" ).setup( {
                signs = {
                    add          = { text = "┃" },
                    change       = { text = "┃" },
                    delete       = { text = "_" },
                    topdelete    = { text = "‾" },
                    changedelete = { text = "~" },
                    untracked    = { text = "┆" },
                },
                signs_staged = {
                    add          = { text = "┃" },
                    change       = { text = "┃" },
                    delete       = { text = "_" },
                    topdelete    = { text = "‾" },
                    changedelete = { text = "~" },
                    untracked    = { text = "┆" },
                },
                signs_staged_enable = true,
                signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
                numhl      = true, -- Toggle with `:Gitsigns toggle_numhl`
                linehl     = true, -- Toggle with `:Gitsigns toggle_linehl`
                word_diff  = true, -- Toggle with `:Gitsigns toggle_word_diff`
                watch_gitdir = {
                    follow_files = true
                },
                auto_attach = true,
                attach_to_untracked = false,
                current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
                current_line_blame_opts = {
                    virt_text = true,
                    virt_text_pos = "eol", -- "eol", "overlay", "right_align"
                    delay = 1000,
                    ignore_whitespace = false,
                    virt_text_priority = 100,
                    use_focus = true,
                },
                current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
                sign_priority = 6,
                update_debounce = 100,
                status_formatter = nil, -- Use default
                max_file_length = 40000, -- Disable if file is longer than this (in lines)
                preview_config = {
                    -- Options passed to nvim_open_win
                    border = "single",
                    style = "minimal",
                    relative = "cursor",
                    row = 0,
                    col = 1
                },
                debug_mode = false,
            } )
        end,
    }
}
