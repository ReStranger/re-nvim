return {
    "xiyaowong/transparent.nvim",
    lazy = false,
    dependencies = { "akinsho/bufferline.nvim" },
    opts = {
        extra_groups = {
            "NormalFloat",
            "FloatBorder",
            "GitSignsAdd",
            "GitSignsChange",
            "GitSignsDelete",
            "GitSignsAddNr",
            "GitSignsChangeNr",
            "GitSignsDeleteNr",
            "GitSignsAddLn",
            "GitSignsChangeLn",
            "GitSignsDeleteLn",
            "GitSignsCurrentLineBlame",
            "LazyProp",
            "LazyDimmed",
        },
        exclude_groups = {},
        on_clear = function() end,
    },
    config = function(_, opts)
        require("transparent").setup(opts)
    end,
    keys = {
        {
            "<leader>tt",
            "<cmd>TransparentToggle<cr>",
            desc = "Transparent Toggle",
        },
    },
}
