---@diagnostic disable: undefined-global
local api = vim.api
---@diagnostic enable: undefined-global

require("mason-nvim-lint").setup {
    automatic_installation = os.getenv "NH_FLAKE" == nil,
}
require("lint").linters_by_ft = {
    javascript = { "eslint_d" },
    typescript = { "eslint_d" },
    typescriptreact = { "eslint_d" },
    javascriptreact = { "eslint_d" },
    python = { "mypy" },
}

api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
        require("lint").try_lint()
    end,
})
