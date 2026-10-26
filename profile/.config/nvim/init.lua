-- vim:foldmethod=marker

_G.Config = {}

local augroup = vim.api.nvim_create_augroup( "init", { clear = true } )

-- language, encoding {{{
if vim.fn.has( "win32" ) == 1 then
    vim.cmd( "language English" )
else
    vim.cmd( "silent! language messages C" )
end

vim.o.langmenu = "none"
-- }}}

-- terminal, gui {{{
-- vim.o.guifont = "LiterationMono Nerd Font:h10:cRUSSIAN"

vim.o.guicursor = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175"

vim.o.termguicolors = true

-- if vim.fn.has( "win32" ) == 1 then
    vim.cmd.source( vim.env.VIMRUNTIME .. "/scripts/mswin.vim" )
-- end
-- }}}

vim.o.modeline = true

-- folding {{{
function Config.fold_text ()
    local line = vim.fn.getline( vim.v.foldstart )

    -- replace tabs with spaces
    line = ( line:gsub( "\t", string.rep( " ", vim.bo.tabstop ) ) )

    -- remove trailing spaces
    line = ( line:gsub( " +$", "" ) )

    -- leading indent: first space becomes "▸", the rest become "."
    local indent, rest = line:match( "^( *)(.*)$" )

    if indent == "" then
        return "▸" .. rest
    end

    return "▸" .. string.rep( ".", #indent - 1 ) .. rest
end

vim.o.foldtext = "v:lua.Config.fold_text()"
vim.o.foldenable = true
vim.o.foldlevel = 99
vim.o.foldlevelstart = 0
vim.o.foldmethod = "manual"
vim.o.foldcolumn = "0" -- auto:1 -- controlled by statuscolumn
vim.opt.fillchars:append( { foldopen = "▾", foldclose = "▸", foldsep = "┋" } )
-- }}}

vim.cmd( "syntax manual" )

-- colors
vim.o.background = "dark"
vim.o.cursorline = true
vim.o.cursorcolumn = false
vim.o.hlsearch = true

-- backspace and cursor keys wrap to previous/next line
vim.o.backspace = "indent,eol,start"
vim.o.whichwrap = vim.o.whichwrap .. ",<,>,[,]"

vim.o.history = 50      -- keep 50 lines of command line history
vim.o.ruler = true      -- show the cursor position all the time
vim.o.showcmd = true    -- display incomplete commands
vim.o.incsearch = true  -- you will see results while you type
vim.o.ignorecase = true -- ignore case when searching
vim.o.smartcase = true  -- use smartcase

vim.o.backup = false

-- swap
-- vim.o.swapfile = false

-- undo
vim.o.undofile = true

vim.o.scrolloff = 2
vim.o.wrap = true         -- включаем перенос строк
-- vim.o.linebreak = true -- перенос строк по словам, а не по буквам
vim.o.tabstop = 4         -- размер табуляции
vim.o.shiftwidth = 4      -- размер сдвига при нажатии на клавиши << и >>
vim.o.autoindent = true   -- копирует отступ от предыдущей строки
vim.o.smartindent = true  -- включаем 'умную' автоматическую расстановку отступов

vim.o.number = true -- show line numbers
vim.o.mouse = "a"

-- spelling && keyboard layout {{{
vim.o.spellfile = vim.fn.stdpath( "data" ) .. "/spell/default.add"
vim.o.mousemodel = "popup_setpos"
vim.o.imsearch = -1
-- }}}

-- file settings {{{
vim.o.fileencodings = "ucs-bom,utf-8,cp1251"
vim.o.fileformats = "unix,dos"
vim.o.fileformat = "unix"
vim.o.bomb = false
-- }}}

-- tabline
vim.o.laststatus = 2
vim.o.showtabline = 2

-- disable bell
vim.o.errorbells = false
vim.o.visualbell = true

-- don't reload modified file automatically
vim.o.autoread = false

-- notify on file modified
vim.api.nvim_create_autocmd( "FocusGained", {
    group = augroup,
    pattern = "*",
    command = "checktime",
} )

-- set fill char for diff
vim.opt.fillchars:append( { diff = "╱" } )

vim.opt.langmap = "ёйцукенгшщзхъфывапролджэячсмитьбю;`qwertyuiop[]asdfghjkl\\;'zxcvbnm\\,.,"
    .. "ЁЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ;~QWERTYUIOP{}ASDFGHJKL:\"ZXCVBNM<>";

-- set titlestring {{{
function Config.title_string () -- {{{
    local title = ""

    if vim.bo.modified then
        title = title .. "[+] "
    end

    local name = vim.fn.expand( "%F" )

    if name == "" then
        -- no name
        title = title .. "[No Name]"
    elseif name:find( "term://", 1, true ) then
        -- neovim terminal
        title = ( name:gsub( "(term:)//.*:(.*)", "%1 %2", 1 ) )
    else
        -- filename
        title = title .. vim.fn.fnamemodify( name, ":t" )
        title = title .. " (" .. vim.fn.fnamemodify( name, ":p:h" ) .. ")"
    end

    title = ( title:gsub( "\\", "/" ) )

    return title
end -- }}}

vim.o.titlestring = "%{v:lua.Config.title_string()}"

-- mandatory for neovim-qt
vim.o.title = true
-- }}}

-- always open help in a new tab
vim.api.nvim_create_autocmd( "BufEnter", {
    group = augroup,
    pattern = "*.txt",
    callback = function ()
        if vim.bo.filetype == "help" then
            vim.cmd.wincmd( "T" )
        end
    end,
} )

-- prevent create .netrwhist
vim.g.netrw_dirhistmax = 0

-- disable highlight for html comments
vim.g.html_wrong_comments = 1

-- allow redefine tab width for yaml
vim.g.yaml_recommended_style = 0

-- make highlight for "sh" files  compatible with "bash"
vim.g.is_posix = 1

-- configure folding for "sh" scripts
vim.g.sh_fold_enabled = 3

-- disable hide of double quotes in json
vim.g.vim_json_conceal = 0

-- use "::" comments for "dosbatch" filetype
vim.g.dosbatch_colons_comment = 1

-- init
require( "config/state" )
require( "config/keymap" )

-- load plugins
require( "config/lazy" )
