return {
    "ibhagwan/fzf-lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        winopts = {
            preview = {
                default = "bat",
            },
        },
        defaults = {
            file_ignore_patterns = { "%.git/", "%.cache/", "node_modules/", "build/" },
        },
    },
    keys = {
        {
            "<leader>ff",
            function()
                require("fzf-lua").files()
            end,
            mode = "n",
            desc = "Find files",
        },
        {
            "<leader>fo",
            function()
                require("fzf-lua").oldfiles()
            end,
            mode = "n",
            desc = "Recent files",
        },
        {
            "<leader>fq",
            function()
                require("fzf-lua").quickfix()
            end,
            mode = "n",
            desc = "Quickfix list",
        },
        {
            "<leader>fw",
            function()
                require("fzf-lua").live_grep_native()
            end,
            mode = "n",
            desc = "Live grep",
        },
    },
}
