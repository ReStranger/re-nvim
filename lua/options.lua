local opt = vim.opt
local wo = vim.wo

opt.cursorline = true
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

wo.number = true
wo.relativenumber = true
opt.updatetime = 100
wo.signcolumn = "yes"
opt.scrolloff = 8
wo.linebreak = true
opt.virtualedit = "block"
opt.undofile = true
opt.shell = "/usr/bin/env zsh"

opt.mouse = "a"
opt.mousefocus = true

opt.number = true
opt.relativenumber = true

opt.splitbelow = true
opt.splitright = true

opt.shortmess:append "c"

opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.smartindent = true
