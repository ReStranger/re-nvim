local map = vim.keymap.set
local cmd = vim.cmd
local g = vim.g
local bufnr = vim.api.nvim_get_current_buf()

g.rustaceanvim = {
  tools = {
  },
  server = {
    default_settings = {
      ['rust-analyzer'] = {
        ['rust-analyzer.rust.analyzerTargetDir'] = true,
        cargo = {
          allFeatures = true,
          loadOutDirsFromCheck = true,
          runBuildScripts = true,
        },
        checkOnSave = {
          allFeatures = true,
          command = "clippy",
        },
        diagnostics = {
          enable = false;
        },
        experimental = {
          serverStatusNotification = true
        }
      },
    },
  },
}
