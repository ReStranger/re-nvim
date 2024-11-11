local mason_lspconfig = require "mason-lspconfig"
local mason_tool_installer = require "mason-tool-installer"
require("mason").setup {
  ui = {
    icons = {
      package_installed = "",
      package_pending = "",
      package_uninstalled = "",
    },
  },
}
mason_lspconfig.setup {
  ensure_installed = {
    -- lua stuff
    "lua_ls", --x86_64 only, also install in you $PATH
    -- web lsp
    "html",
    "cssls",
    "ts_ls",
    -- c/cpp lsp
    "clangd", --x86_64 only, also install in you $PATH
    -- rust lsp
    "rust_analyzer", --x86_64 only, also install in you $PATH
    -- python lsp
    "pyright",
    "ruff_lsp",
    -- bash stuff
    "bashls",
    -- markdown stuff
    "marksman",
    -- hyprlang
    "hyprls",
    -- nix stuff
    "rnix",
  },
  automatic_installation = false,
}
mason_tool_installer.setup {
  ensure_installed = {
    -- lua stuff
    "stylua", --x86_64 only, also install in you $PATH
    -- web stuff
    "prettierd",
    "eslint_d",
    "js-debug-adapter",
    -- c/cpp stuff
    "clang-format",
    -- python stuff
    "black",
    "mypy",
    "debugpy",
    -- nix stuff
    "nixpkgs-fmt",
  },
  automatic_installation = false,
}
