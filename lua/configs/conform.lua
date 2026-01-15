require("mason-conform").setup {
    automatic_installation = os.getenv "NH_FLAKE" == nil,
}

local options = {
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
}

require("conform").formatters.clang_format = {
    args = { "--style={BasedOnStyle: Google, IndentWidth: 4}" },
}

require("conform").setup(options)
