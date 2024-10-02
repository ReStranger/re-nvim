require "nvchad.mappings"

local map = vim.keymap.set
local api = vim.api

map("n", ";", ":", { desc = "CMD enter command mode" })

-- Отключение стрелок в нормальном режиме
api.nvim_set_keymap("n", "<Up>", "<NOP>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<Down>", "<NOP>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<Left>", "<NOP>", { noremap = true, silent = true })
api.nvim_set_keymap("n", "<Right>", "<NOP>", { noremap = true, silent = true })

-- Отключение стрелок в режиме вставки
api.nvim_set_keymap("i", "<Up>", "<NOP>", { noremap = true, silent = true })
api.nvim_set_keymap("i", "<Down>", "<NOP>", { noremap = true, silent = true })
api.nvim_set_keymap("i", "<Left>", "<NOP>", { noremap = true, silent = true })
api.nvim_set_keymap("i", "<Right>", "<NOP>", { noremap = true, silent = true })

-- Отключение Backspace в нормальном режиме
api.nvim_set_keymap("n", "<BS>", "<NOP>", { noremap = true, silent = true })
-- Отключение Backspace в режиме вставки
api.nvim_set_keymap("i", "<BS>", "<NOP>", { noremap = true, silent = true })
-- Отключение Backspace в визуальном режиме
api.nvim_set_keymap("v", "<BS>", "<NOP>", { noremap = true, silent = true })

-- TMUX
map("n", "<c-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "Tmux Left" })
map("n", "<c-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "Tmux Down" })
map("n", "<c-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "Tmux Up" })
map("n", "<c-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "Tmux Right" })
map("n", "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>", { desc = "Tmux Previous" })

-- UFO
map("n", "zR", require("ufo").openAllFolds, { desc = "UFO Open all folds" })
map("n", "zM", require("ufo").closeAllFolds, { desc = "UFO Close all folds" })
map("n", "K", function()
  local winid = require("ufo").peekFoldedLinesUnderCursor()
  if not winid then
    vim.lsp.buf.hover()
  end
end, { desc = "UFO LSP hover" })
-- AI
map("i", "<C-g>", function()
  return vim.fn["codeium#Accept"]()
end, { expr = true, silent = true, desc = "Codeium Accept" })
map("i", "<c-;>", function()
  return vim.fn["codeium#CycleCompletions"](1)
end, { expr = true, silent = true, desc = "Codeium Next Completions" })
map("i", "<c-,>", function()
  return vim.fn["codeium#CycleCompletions"](-1)
end, { expr = true, silent = true, desc = "Codeium Previous Completions" })
map("i", "<C-x>", function()
  return vim.fn["codeium#Clear"]()
end, { expr = true, silent = true, desc = "Codeium Clear" })
map("n", "<leader>ce", function()
  return vim.fn["codeium#Chat"]()
end, { expr = true, silent = true, desc = "Codeium Chat" })

-- DEBUGGER
map("n", "<leader>db", function()
  require("dap").toggle_breakpoint()
end, { desc = "DAP Toggle Breakpoint" })

map("n", "<leader>ds", function()
  require("dap").continue()
end, { desc = "DAP Start" })

map("n", "<leader>dn", function()
  require("dap").step_over()
end, { desc = "DAP Step Over" })

map("n", "<leader>dus", function()
  local widgets = require "dap.ui.widgets"
  local sidebar = widgets.sidebar(widgets.scopes)
  sidebar.open()
end, { desc = "DAP Open debugging sidebar" })
map("n", "<leader>dpr", function()
  require("dap-python").test_method()
end, { desc = "DAP Python test method" })

map("n", "<leader>dcu", function()
  require("crates").upgrade_all_crates()
end, { desc = "DAP Update crates" })

-- Keyboard users
map("n", "<C-t>", function()
  require("menu").open "default"
end, {})

-- mouse users + nvimtree users!
map("n", "<RightMouse>", function()
  vim.cmd.exec '"normal! \\<RightMouse>"'

  local options = vim.bo.ft == "NvimTree" and "nvimtree" or "default"
  require("menu").open(options, { mouse = true })
end, {})
map("n", "<leader>ra", function()
  require("ui.renamer").open "default"
end)
