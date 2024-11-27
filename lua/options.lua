require "nvchad.options"

local o = vim.o
local opt = vim.opt
local g = vim.g
local api = vim.api

o.cursorlineopt = "both"
opt.relativenumber = true
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.tabstop = 2
opt.shiftwidth = 2
opt.incsearch = true
g.dap_virtual_text = true
g.codeium_enabled = true
api.nvim_create_user_command("Q", "q", {})

vim.filetype.add {
  pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
}
require("cmp").setup {
  window = {
    completion = {
      border = "rounded",
    },
    documentation = {
      border = "rounded",
    },
  },
}
