local capabilities = require('cmp_nvim_lsp').default_capabilities()


local lspconfig = require "lspconfig"
local api = vim.api
local buf = vim.buf
local servers = {
  "lua_ls",
  "html",
  "cssls",
  "ts_ls",
  "clangd",
  "pyright",
  "ruff",
  "bashls",
  "nixd",
  "marksman",
  "hyprls",
}

-- lsps with default config
for _, a in ipairs(servers) do
  lspconfig[a].setup {
    capabilities = capabilities,
  }
end

lspconfig.pyright.setup {
  settings = {
    pyright = {
      disableOrganizeImports = true,
    },
    python = {
      analysis = {
        ignore = { "*" },
      },
    },
  },
}

lspconfig.clangd.setup {
  cmd = { "clangd", "--compile-commands-dir=." },
}

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = { api.nvim_buf_get_name(0) },
  }
  buf.execute_command(params)
end

lspconfig.ts_ls.setup {
  init_options = {
    preferences = {
      disableSuggestions = true,
    },
  },
  commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize Imports",
    },
  },
}
