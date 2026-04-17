return {
    "folke/todo-comments.nvim",
    event = "VeryLazy",
    opts = {},
    keys = {
        {
            "<leader>st",
            function()
                require("todo-comments.fzf").todo()
            end,
            desc = "Todo",
        },
        {
            "<leader>sT",
            function()
                require("todo-comments.fzf").todo { keywords = { "TODO", "FIX", "FIXME" } }
            end,
            desc = "Todo/Fix/Fixme",
        },
    },
}
