local root = vim.fn.stdpath( "data" ) .. "/lazy"
local lazypath = root .. "/lazy.nvim"

if not ( vim.uv or vim.loop ).fs_stat( lazypath ) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system( {  "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath } )

    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo( {
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {} )

        vim.fn.getchar()

        os.exit( 1 )
    end
end

vim.opt.rtp:prepend( lazypath )

vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"

-- DOCS: https://lazy.folke.io/configuration
require( "lazy" ).setup( {
    lockfile = root .. "/lazy-lock.json",
    defaults = {
        lazy = false,
    },
    spec = {
        {
            import = "plugins"
        },
    },
    install = {
        missing = true,
    },
    checker = {
        enabled = false,
        notify = true,
    },
    change_detection = {
        enabled = true,
        notify = false,
    },
    ui = {
        icons = {
            cmd = "⌘",
            config = "🛠",
            event = "📅",
            ft = "📂",
            init = "⚙",
            keys = "🗝",
            plugin = "🔌",
            runtime = "💻",
            require = "🌙",
            source = "📄",
            start = "🚀",
            task = "📌",
            lazy = "💤 ",
        },
    },
    dev = {
        path = vim.fn.has( "win32" ) == 1 and "d:/projects/zdm" or "/var/local/zdm",
        fallback = true,
    },
} )
