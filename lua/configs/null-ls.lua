local null_ls = require("null-ls")

local b = null_ls.builtins

local sources = {

	b.diagnostics.mypy,
}

null_ls.setup({
	debug = true,
	sources = sources,
})
