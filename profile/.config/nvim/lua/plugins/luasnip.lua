-- [ "bash" ] = { "sh" },
-- [ "html/javascript" ] = { "javascript", "html/javascript" },
-- [ "vue" ] = { "html", "vue/html" },
-- [ "vue/javascript" ] = { "javascript", "html/javascript", "vue/javascript" },

local M = {}
local loaded_filetypes = {}

function M.load_snippets_for_ft ( filetype, snippets_dir )
    local luasnip = require( "luasnip" )
    local yaml = require( "tinyyaml" )

    if loaded_filetypes[ filetype ] then return end

    local path = snippets_dir .. "/" .. filetype .. ".yaml"
    local file = io.open( path, "r" )
    if not file then return end

    local content = file:read( "*all" )
    file:close()

    local success, parsed_data = pcall( yaml.parse, content )
    if not success or type( parsed_data ) ~= "table" then
        -- vim.notify( "Failed to parse YAML snippet file: " .. path, vim.log.levels.ERROR )
        return
    end

    local snippets = {}

    for name, snip in pairs( parsed_data ) do
        if snip.prefix and snip.body then
            local parsed_snippet

            if type( snip.prefix ) == "string" then
                parsed_snippet = luasnip.parser.parse_snippet(
                    {
                        name = name,
                        trig = snip.prefix,
                    },
                    snip.body
                )
            else
                for index, prefix in ipairs( snip.prefix ) do
                    parsed_snippet = luasnip.parser.parse_snippet(
                        {
                            name = name .. "/" .. prefix,
                            trig = prefix,
                        },
                        snip.body
                    )
                end
            end

            table.insert( snippets, parsed_snippet )
        end
    end

    luasnip.add_snippets( filetype, snippets )

    loaded_filetypes[ filetype ] = true
end

function M.setup( opts )
    local snippets_dir = opts.path or ( vim.fn.stdpath( "config" ) .. "/snippets" )

    vim.api.nvim_create_autocmd( "FileType", {
        pattern = "*",
        callback = function( ev )
            M.load_snippets_for_ft( "global", snippets_dir )
            M.load_snippets_for_ft( ev.match, snippets_dir )
        end,
    })
end

return {
    {
        "l3mon4d3/luasnip",
        version = "*",
        -- build = "make install_jsregexp"
        config = function ()
            require( "luasnip" ).config.set_config( {
            } )

            M.setup( {
                path = vim.fn.stdpath( "config" ) .. "/snippets"
            } );
        end
    }
}
