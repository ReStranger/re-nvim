require "nvchad.options"

local o = vim.o
local opt = vim.opt
local g = vim.g

o.cursorlineopt = "both"
opt.relativenumber = true
opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
g.dap_virtual_text = true

vim.filetype.add {
  pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
}
