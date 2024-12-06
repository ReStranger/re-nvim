local on_attach = on_attach
local on_init = on_init
local capabilities = require('cmp_nvim_lsp').default_capabilities()
on_attach = function(_, bufnr)
  local function opts(desc)
    return { buffer = bufnr, desc = "LSP " .. desc }
  end

  map("n", "gD", vim.lsp.buf.declaration, opts "Go to declaration")
  map("n", "gd", vim.lsp.buf.definition, opts "Go to definition")
  map("n", "gi", vim.lsp.buf.implementation, opts "Go to implementation")
  map("n", "<leader>sh", vim.lsp.buf.signature_help, opts "Show signature help")
  map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "Add workspace folder")
  map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "Remove workspace folder")

  map("n", "<leader>wl", function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, opts "List workspace folders")

  map("n", "<leader>D", vim.lsp.buf.type_definition, opts "Go to type definition")
  map("n", "<leader>ra", require "nvchad.lsp.renamer", opts "NvRenamer")

  map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts "Code action")
  map("n", "gr", vim.lsp.buf.references, opts "Show references")
end


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
    on_attach = on_attach,
    on_init = on_init,
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
