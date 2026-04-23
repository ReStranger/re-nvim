return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    opts = {

        opts = {
            language = "Russian",
        },
        interactions = {
            chat = {
                adapter = "opencode",
                opts = {
                    completion_provider = "blink",
                },
            },
            inline = {
                adapter = {
                    name = "opencode",
                    model = "claude-haiku-4-5-20251001",
                },
            },
        },
    },
    keys = {
        {
            "<leader>ca",
            "<cmd>CodeCompanionActions<CR>",
            mode = { "n", "v" },
            desc = "CodeCompanion Actions",
        },
        {
            "<leader>cc",
            "<cmd>CodeCompanionChat<CR>",
            mode = { "n", "v" },
            desc = "CodeCompanion Chat",
        },
        {
            "<leader>ct",
            "<cmd>CodeCompanionChat Toggle<CR>",
            mode = { "n", "v" },
            desc = "CodeCompanion Chat",
        },
        {
            "<leader>cp",
            "<cmd>CodeCompanion<CR>",
            mode = { "n", "v" },
            desc = "CodeCompanion",
        },
        { "<leader>da", "<cmd>CodeCompanionChat Add<cr>", mode = "v" },
    },
}
