local M = {}
local loaded_filetypes = {}
local treesitter_is_available = pcall( require, "nvim-treesitter.util" )

-- [ "bash" ] = { "sh" },
-- [ "html/javascript" ] = { "javascript", "html/javascript" },
-- [ "vue" ] = { "html", "vue/html" },
-- [ "vue/javascript" ] = { "javascript", "html/javascript", "vue/javascript" },

-- private
local function get_parser_filetype ( lang )
  if lang then

    -- NOTE: first element [ 1 ] is always the lang itself
    -- other element placed in random order
    -- XXX: unclear how to use this data, how to distinguish lang from filetype
    -- return vim.treesitter.language.get_filetypes( lang )[ 2 ] or lang

    return lang
  else
    return ""
  end
end

-- public
function M.setup( options )
    local snippets_dir

    if options then
        snippets_dir = options.path
    end

    if not snippets_dir then
        snippets_dir = vim.fn.stdpath( "config" ) .. "/snippets"
    end

    vim.api.nvim_create_autocmd( "FileType", {
        pattern = "*",
        callback = function( ev )
            M.load_snippets_for_ft( "global", snippets_dir )
            M.load_snippets_for_ft( ev.match, snippets_dir )
        end,
    })
end

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
        if snip.trigger and snip.body then
            local parsed_snippet

            if type( snip.trigger ) == "string" then
                parsed_snippet = luasnip.parser.parse_snippet(
                    {
                        name = name,
                        trig = snip.trigger,
                        dscr = snip.description or name,
                        condition = M.create_condition( filetype ),
                    },
                    snip.body
                )
            else
                for index, trigger in ipairs( snip.trigger ) do
                    parsed_snippet = luasnip.parser.parse_snippet(
                        {
                            name = name .. "/" .. trigger,
                            trig = trigger,
                            dscr = snip.description or name,
                            condition = M.create_condition( filetype ),
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

function M.create_condition ( filetype )
    return function ()
        return true
    end
end

function M.get_ft_at_cursor ( bufnr )
  local filetypes = {
    filetype = "",
    injected_filetype = "",
  }

  if treesitter_is_available then
    local cur_node = vim.treesitter.get_node( { bufnr = bufnr } )

    if cur_node then
      local parser = vim.treesitter.get_parser( bufnr )
      local language_tree_at_cursor = parser:language_for_range( { cur_node:range() } )
      local language_at_cursor = language_tree_at_cursor:lang()

      local filetype = get_parser_filetype( language_at_cursor )

      if filetype ~= "" then
        filetypes.filetype = filetype

        local parent_language_tree = language_tree_at_cursor:parent()

        if parent_language_tree then
          local parent_language = parent_language_tree:lang()
          local parent_filetype = get_parser_filetype( parent_language )

          if parent_filetype ~= "" then
            filetypes.injected_filetype = parent_filetype .. "/" .. filetype
          end
        end

        return filetypes
      end
    end
  end

  filetypes.filetype = vim.bo[ bufnr ].filetype or ""

  return filetypes
end

return M
