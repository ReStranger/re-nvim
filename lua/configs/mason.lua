require("mason").setup {
  ui = {
    icons = {
      package_installed = "",
      package_pending = "",
      package_uninstalled = "",
    },
  },
}
require("mason-lspconfig").setup {
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
    "ruff",
    -- bash stuff
    "bashls",
    -- markdown stuff
    "marksman",
    -- hyprlang
    "hyprls",
    -- nix stuff
    "rnix",
  },
  automatic_installation = true,
}
require("mason-tool-installer").setup {
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
  automatic_installation = true,
}
require("mason-nvim-dap").setup {
  ensure_installed = { "python", "js" },
  automatic_installation = true,
}
