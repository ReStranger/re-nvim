require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })

-- TMUX
map("n", "<c-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "Tmux Left"})
map("n", "<c-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "Tmux Down"})
map("n", "<c-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "Tmux Up"})
map("n", "<c-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "Tmux Right"})
map("n", "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>", { desc = "Tmux Previous"})

-- UFO
map("n", "zR", require("ufo").openAllFolds, { desc = "UFO Open all folds" })
map("n", "zM", require("ufo").closeAllFolds, { desc = "UFO Close all folds" })
map("n", "K", function()
  local winid = require("ufo").peekFoldedLinesUnderCursor()
  if not winid then
    vim.lsp.buf.hover()
  end
end, { desc = "UFO LSP hover" })

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

-- Auto run code
local function current_file_path()
  return vim.api.nvim_buf_get_name(0)
end

local function current_file_type()
  return vim.bo.filetype
end

local function c_compiler()
  if vim.fn.executable "clang" == 1 then
    return "clang"
  elseif vim.fn.executable "gcc" == 1 then
    return "gcc"
  else
    return "none"
  end
end

local function cpp_compiler()
  if vim.fn.executable "clang++" == 1 then
    return "clang++"
  elseif vim.fn.executable "g++" == 1 then
    return "g++"
  else
    return "none"
  end
end

map("n", "<leader>cr", function()
  local file_path = current_file_path()
  local file_type = current_file_type()

  if file_type == "c" then
    local output_file = file_path:gsub("%..*$", "")
    local compiler = c_compiler()
    if compiler == "none" then
      vim.cmd "echo 'No C compiler found'"
    else
      local compile_cmd = string.format("%s %s -o %s && time %s", compiler, file_path, output_file, output_file)
      vim.cmd("!" .. compile_cmd)
    end
  elseif file_type == "cpp" then
    local output_file = file_path:gsub("%..*$", "")
    local compiler = cpp_compiler()
    if compiler == "none" then
      vim.cmd "echo 'No C++ compiler found'"
    else
      local compile_cmd = string.format("%s %s -o %s && time %s", compiler, file_path, output_file, output_file)
      vim.cmd("!" .. compile_cmd)
    end
  elseif file_type == "python" then
    local compile_cmd = string.format("time python %s", file_path)
    vim.cmd("!" .. compile_cmd)
  elseif file_type == "rust" then
    local compile_cmd = "time cargo run"
    vim.cmd("!" .. compile_cmd)
  else
    vim.cmd "echo 'Unsupported file type'"
  end
end, { desc = "BUILD SYSTEM Build and run project" })
