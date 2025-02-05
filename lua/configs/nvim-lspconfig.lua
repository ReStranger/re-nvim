---@diagnostic disable: undefined-global
local api = vim.api
local buf = vim.buf
local diagnostic = vim.diagnostic
local lsp = vim.lsp
---@diagnostic enable: undefined-global

local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("mason-lspconfig").setup {

    ensure_installed = {
        "rust_analyzer",
    },
    automatic_installation = true,
}

local border = {
    { "╭", "FloatBorder" },

    { "─", "FloatBorder" },
    { "╮", "FloatBorder" },
    { "│", "FloatBorder" },
    { "╯", "FloatBorder" },
    { "─", "FloatBorder" },

    { "╰", "FloatBorder" },

    { "│", "FloatBorder" },
}

-- LSP settings (for overriding per client)
local handlers = {
    ["textDocument/hover"] = lsp.with(lsp.handlers.hover, { border = "rounded" }),
    ["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, { border = "rounded" }),
}
diagnostic.config {
    float = {
        border = "rounded",
    },
}

-- To instead override globally
local orig_util_open_floating_preview = lsp.util.open_floating_preview
function lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or border
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

local lspconfig = require "lspconfig"
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
        handlers = handlers,
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
