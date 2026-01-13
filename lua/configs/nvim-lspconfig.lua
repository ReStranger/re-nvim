---@diagnostic disable: undefined-global
local api = vim.api
local buf = vim.buf
local diagnostic = vim.diagnostic
local lsp = vim.lsp
---@diagnostic enable: undefined-global

require("mason-lspconfig").setup {
    ensure_installed = (os.getenv "NH_FLAKE" == nil) and {
        "rust_analyzer",
    } or {},
    automatic_installation = os.getenv "NH_FLAKE" == nil,
}

diagnostic.config {
    float = {
        border = "rounded",
    },
    signs = {
        text = {
            [diagnostic.severity.ERROR] = "",
            [diagnostic.severity.HINT] = "󰌵",
            [diagnostic.severity.INFO] = "",
            [diagnostic.severity.WARN] = "",
        },
    },
    underline = true,
    update_in_insert = false,
    virtual_text = true,
}

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

lsp.enable(servers)

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
        "--compile-commands-dir=./build",
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
