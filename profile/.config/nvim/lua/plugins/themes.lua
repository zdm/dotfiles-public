local function configureColors ()

    -- comments
    vim.api.nvim_set_hl( 0, "@comment.error", { bg = "#ff0000", fg = "#000000" } )
    vim.api.nvim_set_hl( 0, "@comment.warning", { bg = "#ba8e23", fg = "#000000" } )
    vim.api.nvim_set_hl( 0, "@comment.note", { fg = "#ae81ff" } )
    vim.api.nvim_set_hl( 0, "@comment.todo", { bg = "#eeee00", fg = "#ff0000" } )
    vim.api.nvim_set_hl( 0, "@string.special.url", { underline = true, fg = "#ae81ff" } )

    do return end

    -- diff
    vim.cmd.highlight( {
        "DiffAdd",
        "term=bold",
        "cterm=bold", "ctermbg=22",      "ctermfg=Green",
        "gui=bold",   "guibg=DarkGreen", "guifg=Green"
    } )

    vim.cmd.highlight( {
        "DiffChange",
        "term=bold",
        "cterm=bold", "ctermbg=24",     "ctermfg=Cyan",
        "gui=bold",   "guibg=DarkCyan", "guifg=Cyan"
    } )

    vim.cmd.highlight( {
        "DiffDelete",
        "term=bold",
        "cterm=bold", "ctermbg=124",   "ctermfg=Red",
        "gui=bold",   "guibg=DarkRed", "guifg=Red"
    } )

    vim.cmd.highlight( {
        "CursorLine",
        "term=NONE",
        "cterm=bold", "ctermbg=NONE", "ctermfg=NONE",
        "gui=bold",   "guibg=Grey25", "guifg=NONE"
    } )

    vim.cmd.highlight( {
        "SignColumn",
        "term=NONE",
        "cterm=bold", "ctermbg=NONE", "ctermfg=NONE",
        "gui=bold",   "guibg=NONE",   "guifg=NONE"
    } )

    vim.cmd.highlight( {
        "Folded",
        "term=NONE",
        "cterm=bold", "ctermbg=NONE", "ctermfg=178",
        "gui=NONE",   "guibg=Grey30", "guifg=Gold"
    } )

    vim.cmd.highlight( { "Pmenu", "guifg=grey100", "guibg=grey10" } )
    vim.cmd.highlight( { "PmenuSel", "gui=bold", "guifg=grey100", "guibg=grey45" } )
    vim.cmd.highlight( { "PmenuSbar", "guifg=grey100", "guibg=grey10" } )
    vim.cmd.highlight( { "PmenuThumb", "guifg=grey100" } )
end

vim.api.nvim_create_autocmd( "ColorScheme", {
    callback = configureColors
} )

vim.api.nvim_create_autocmd( "TextYankPost", {
    callback = function ( ev )
        vim.hl.on_yank( {
            higroup="Visual",
            timeout=300
        } )
    end
} )

-- vim.cmd.colorscheme( "desert" )

return {
    {
        "bluz71/vim-nightfly-colors",
        -- enabled = false,
        priority = 100,
        init = function ()
            vim.g.nightflyCursorColor = true
            vim.g.nightflyNormalFloat = true
        end,
        config = function ()
            vim.cmd.colorscheme( "nightfly" )
        end
    },
    {
        "tanvirtin/monokai.nvim",
        enabled = false,
        priority = 100,
        config = function ()
            require( "monokai" ).setup( {
                -- palette = require( "monokai" ).pro,
                italics = false
            } )
        end
    },
    {
        "srcery-colors/srcery-vim",
        enabled = false,
        priority = 100,
        config = function ()
            vim.cmd.colorscheme( "srcery" )
        end
    },
    {
        "kuznetsss/meadow.nvim",
        enabled = false,
        priority = 100,
        config = function ()
            require( "meadow" ).setup( {
                color_saturation = 80, -- contrast (0-100)
                color_value = 80, -- brightness (0-100)
            } )

            vim.cmd.colorscheme( "meadow" )
        end
    },
}
