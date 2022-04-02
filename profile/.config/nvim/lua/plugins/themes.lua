local priority = 100

local function hl ( name, options )
    vim.api.nvim_set_hl( 0, name, options )
end

local function configureColors ()

    -- comments
    hl( "@comment.error", { bg = "DarkRed", fg = "White" } )
    hl( "@comment.warning", { bg = "DarkYellow", fg = "Black" } )
    hl( "@comment.note", { fg = "#ae81ff" } )
    hl( "@comment.todo", { bg = "DarkYellow", fg = "DarkRed" } )
    hl( "@string.special.url", { underline = true, fg = "#ae81ff" } )

    do return end

    -- diff
    hl( "DiffAdd", { bold = true, bg = "DarkGreen", fg = "White" } )
    hl( "DiffChange", { bold = true, bg = "DarkCyan", fg = "White" } )
    hl( "DiffDelete", { bold = true, bg = "DarkRed", fg = "White" } )

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
        enabled = false,
        priority = priority,
        init = function ()
            vim.g.nightflyCursorColor = true
            vim.g.nightflyNormalFloat = true
        end,
        config = function ()
            vim.cmd.colorscheme( "nightfly" )
        end
    },
    {
        "EdenEast/nightfox.nvim",
        enabled = false,
        priority = priority,
        config = function ()
            require( "nightfox" ).setup( {
                options = {
                    styles = {
                        comments = "italic",
                        keywords = "bold",
                        types = "italic,bold",
                    }
                }
            } )

            vim.cmd.colorscheme( "nightfox" )
            -- vim.cmd.colorscheme( "carbonfox" )
        end,
    },
    {
        "tanvirtin/monokai.nvim",
        enabled = false,
        priority = priority,
        config = function ()
            require( "monokai" ).setup( {
                -- palette = require( "monokai" ).pro,
                italics = false
            } )
        end
    },
    {
        "srcery-colors/srcery-vim",
        -- enabled = false,
        priority = priority,
        init = function ()
            vim.g.srcery_italic = 0
            vim.g.srcery_underline = 0
            vim.g.srcery_undercurl = 1
            vim.g.srcery_strikethrough = 1
            vim.g.srcery_inverse = 0
            vim.g.srcery_inverse_matches = 0
            vim.g.srcery_inverse_match_paren = 0
            vim.g.srcery_bg = { "#000000", 0 }
        end,
        config = function ()
            vim.cmd.colorscheme( "srcery" )

            hl( "CursorLine", {
                bg = "Grey15",
            } )

            hl( "MatchParen", {
                bold = true,
                bg = "Grey30",
                fg = vim.g.srcery_bright_magenta,
            } )
        end
    },
    {
        "kuznetsss/meadow.nvim",
        enabled = false,
        priority = priority,
        config = function ()
            require( "meadow" ).setup( {
                color_saturation = 80, -- contrast (0-100)
                color_value = 80, -- brightness (0-100)
            } )

            vim.cmd.colorscheme( "meadow" )
        end
    },
}
