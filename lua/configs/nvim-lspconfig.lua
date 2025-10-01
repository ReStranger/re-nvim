---@diagnostic disable: undefined-global
local api = vim.api
local buf = vim.buf
local diagnostic = vim.diagnostic
local g = vim.g
local lsp = vim.lsp
---@diagnostic enable: undefined-global

local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("mason-lspconfig").setup {
    ensure_installed = (os.getenv "NH_FLAKE" == nil) and {
        "rust_analyzer",
    } or {},
    automatic_installation = os.getenv "NH_FLAKE" == nil,
}

-- LSP settings (for overriding per client)
local handlers = g.re_nvim_border_style == "rounded"
        and {
            ["textDocument/hover"] = lsp.with(lsp.handlers.hover, { border = "rounded" }),
            ["textDocument/signatureHelp"] = lsp.with(lsp.handlers.signature_help, { border = "rounded" }),
        }
    or {}
diagnostic.config {
    float = {
        border = "rounded",
    },
}

diagnostic.config {
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
}

-- To instead override globally
local orig_util_open_floating_preview = lsp.util.open_floating_preview
function lsp.util.open_floating_preview(contents, syntax, opts, ...)
    opts = opts or {}
    opts.border = opts.border or border
    return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

-- local lspconfig = require "lspconfig"
local servers = {
    "lua_ls",
    "html",
    "cssls",
    "ts_ls",
    "clangd",
    "cmake",
    "qmlls",
    "pyright",
    "ruff",
    "bashls",
    "nixd",
    "marksman",
    "hyprls",
}

-- lsps with default config
for _, name in ipairs(servers) do
    lsp.config(name, {
        handlers = handlers,
        capabilities = capabilities,
    })
    lsp.enable(name)
end


lsp.config("pyright", {
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
})

lsp.config("clangd", {
    cmd = {
        "clangd",
        "--background-index",
        "--header-insertion-decorators",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--fallback-style=llvm",
        "--clang-tidy",
        "--clang-tidy-checks=*",
        "--compile-commands-dir=.",
        "--all-scopes-completion",
        "--cross-file-rename",
        "--pch-storage=memory",
    },
    init_options = {
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true,
    },
    settings = {
        clangd = {
            InlayHints = {
                Designators = true,
                Enabled = true,
                ParameterNames = true,
                DeducedTypes = true,
            },
            fallbackFlags = { "-std=c++20" },
        },
    },
})

local function organize_imports()
    local params = {
        command = "_typescript.organizeImports",
        arguments = { api.nvim_buf_get_name(0) },
    }
    buf.execute_command(params)
end

lsp.config("ts_ls", {
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
})

lsp.config("lua_ls", {
    settings = {
        Lua = {
            hint = {
                enable = true,
            },
        },
    },
})

lsp.config("nixd", {
    settings = {
        nixd = {
            formatting = {
                command = { "nixfmt" },
            },
        },
    },
})
