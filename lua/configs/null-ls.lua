
local null_ls = require "null-ls"
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local b = null_ls.builtins

local sources = {

  b.diagnostics.mypy,
  b.diagnostics.ruff,
}

null_ls.setup {
  debug = true,
  sources = sources,
}
