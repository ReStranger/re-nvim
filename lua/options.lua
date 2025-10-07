---@diagnostic disable: undefined-global
local opt = vim.opt
local g = vim.g
local wo = vim.wo
---@diagnostic enable: undefined-global

-- Disable any visual plugins (like lualine and etc)
g.re_nvim_style = "normal" -- normal | minimal
g.re_nvim_border_style = "none" -- rounded | square | none
g.re_nvim_theme = "touka" -- catppuccin | gruvbox | touka | none

-- Plugins
g.re_nvim_dashboard = true
g.re_nvim_statuscol = true
g.re_nvim_noice = true

opt.cursorline = true
opt.colorcolumn = "120"
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

opt.expandtab = true
opt.tabstop = 4
opt.shiftwidth = 4
opt.softtabstop = 4
opt.smartindent = true
