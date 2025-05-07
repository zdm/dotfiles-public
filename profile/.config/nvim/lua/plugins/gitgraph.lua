return {
    {
        "isakbm/gitgraph.nvim",
        dependencies = {
            "diffview.nvim",
        },
        opts = {
            symbols = {
                commit = "•",
                commit_end = "⦿",
                merge_commit = "⦾",
                merge_commit_end = "⦾",
            },
            format = {
                timestamp = "%Y-%m-%d %H:%M:%S",
                fields = { "hash", "timestamp", "author", "branch_name", "tag" },
            },
            hooks = {
                on_select_commit = function ( commit )
                    vim.cmd( ":DiffviewOpen " .. commit.hash .. "^!" )
                end,
                on_select_range_commit = function ( from, to )
                    vim.cmd( ":DiffviewOpen " .. from.hash .. "~1.." .. to.hash )
                end,
            },
        },
        keys = {
            {
                "<leader>gl",
                function ()
                    if vim.bo.filetype == "gitgraph" then
                        vim.cmd.tabclose()
                    elseif require( "utils" ).ignore_filetypes[ vim.bo.filetype ] then
                        return
                    else
                        vim.cmd.tabnew()

                        require( "gitgraph" ).draw( {
                            pretty = false,
                        }, {
                            all = true,
                            max_count = 5000
                        } )
                    end
                end,
                desc = "GitGraph - Draw",
            },
        },
    },
}
