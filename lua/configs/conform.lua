local conform = require("conform")
local options = {
	formatters_by_ft = {
		lua = { "stylua" },
		css = { "prettierd" },
		html = { "prettierd" },
		javascript = { "prettierd" },
		typescript = { "prettierd" },
		javascriptreact = { "prettierd" },
		typescriptreact = { "prettierd" },
		python = { "black", "mypy" },
		c = { "clang-format" },
		cpp = { "clang-format" },
		markdown = { "prettierd" },
		markdown_inline = { "prettierd" },
	},
	formatters = {
		mypy = {
			command = "~/.local/share/nvim/mason/bin/mypy",
			args = { "--show-column-numbers", "--strict" },
			stdin = true,
			cwd = conform.util.root_file(),
			condition = conform.util.is_python_file,
			exit_codes = { 0 },
		},
	},

	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_fallback = true,
	},
}

require("conform").setup(options)
