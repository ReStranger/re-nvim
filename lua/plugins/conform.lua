return {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = {
        formatters_by_ft = {
            lua = { "stylua" },
            css = { "prettierd" },
            html = { "prettierd" },
            javascript = { "prettierd" },
            typescript = { "prettierd" },
            javascriptreact = { "prettierd" },
            typescriptreact = { "prettierd" },
            python = { "black" },
            c = { "clang_format" },
            cpp = { "clang_format" },
            markdown = { "prettierd" },
            markdown_inline = { "prettierd" },
        },
        formatters = {
            injected = { options = { ignore_errors = true } },
            clang_format = {
                args = { "--style={BasedOnStyle: Google, IndentWidth: 4}" },
            },
        },
    },
    keys = {
        {
            "<leader>lf",
            function()
                require("conform").format { timeout_ms = 500, lsp_fallback = true }
            end,
            mode = "n",
            desc = "Format buffer",
        },
    },
}
