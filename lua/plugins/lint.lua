return {
    "mfussenegger/nvim-lint",
    event = "VeryLazy",
    opts = {
        linters_by_ft = {
            javascript = { "eslint_d" },
            typescript = { "eslint_d" },
            typescriptreact = { "eslint_d" },
            javascriptreact = { "eslint_d" },
            python = { "mypy" },
            cmake = { "cmakelint" },
            nix = { "statix", "deadnix", "nix" },
            dockerfile = { "hadolint" },
            sh = { "shellcheck" },
            zsh = { "zsh" },
        },
    },
    config = function()
        vim.api.nvim_create_autocmd({ "BufWritePost" }, {
            callback = function()
                require("lint").try_lint()
            end,
        })
    end,
}
