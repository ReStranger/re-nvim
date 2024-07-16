require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })

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

-- DEBUGGER
map("n", "<leader>db", "<cmd> DapToggleBreakpoint <CR>", { desc = "DAP Toggle Breakpoint" })
map("n", "<leader>dus", function()
  local widgets = require "dap.ui.widgets"
  local sidebar = widgets.sidebar(widgets.scopes)
  sidebar.open()
end, { desc = "DAP Open debugging sidebar" })
map("n", "<leader>dpr", function()
  require("dap-python").test_method()
end, { desc = "DAP Python test method" })

map("n", "<leader>rcu", function()
  require("crates").upgrade_all_crates()
end, { desc = "DAP Update crates" })
