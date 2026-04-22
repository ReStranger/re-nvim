return {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    opts = {
        servers = {
            ["*"] = {
                capabilities = {
                    workspace = {
                        fileOperations = {
                            didRename = true,
                            willRename = true,
                        },
                    },
                },
                keys = {
                    { "gd", vim.lsp.buf.definition, desc = "Goto Definition", has = "definition" },
                    { "gr", vim.lsp.buf.references, desc = "References", nowait = true },
                    { "gI", vim.lsp.buf.implementation, desc = "Goto Implementation" },
                    { "gy", vim.lsp.buf.type_definition, desc = "Goto T[y]pe Definition" },
                    { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
                    {
                        "K",
                        function()
                            return vim.lsp.buf.hover()
                        end,
                        desc = "Hover",
                    },
                    {
                        "gK",
                        function()
                            return vim.lsp.buf.signature_help()
                        end,
                        desc = "Signature Help",
                        has = "signatureHelp",
                    },
                    {
                        "<c-k>",
                        function()
                            return vim.lsp.buf.signature_help()
                        end,
                        mode = "i",
                        desc = "Signature Help",
                        has = "signatureHelp",
                    },
                    {
                        "<leader>la",
                        vim.lsp.buf.code_action,
                        desc = "Code Action",
                        mode = { "n", "x" },
                        has = "codeAction",
                    },
                    {
                        "<leader>lc",
                        vim.lsp.codelens.run,
                        desc = "Run Codelens",
                        mode = { "n", "x" },
                        has = "codeLens",
                    },
                    {
                        "<leader>lC",
                        vim.lsp.codelens.refresh,
                        desc = "Refresh & Display Codelens",
                        mode = { "n" },
                        has = "codeLens",
                    },
                    {
                        "<leader>lR",
                        function()
                            Snacks.rename.rename_file()
                        end,
                        desc = "Rename File",
                        mode = { "n" },
                        has = { "workspace/didRenameFiles", "workspace/willRenameFiles" },
                    },
                    { "<leader>lr", vim.lsp.buf.rename, desc = "Rename", has = "rename" },
                    {
                        "]]",
                        function()
                            Snacks.words.jump(vim.v.count1)
                        end,
                        has = "documentHighlight",
                        desc = "Next Reference",
                        enabled = function()
                            return Snacks.words.is_enabled()
                        end,
                    },
                    {
                        "[[",
                        function()
                            Snacks.words.jump(-vim.v.count1)
                        end,
                        hak = "documentHighlight",
                        desc = "Prev Reference",
                        enabled = function()
                            return Snacks.words.is_enabled()
                        end,
                    },
                    {
                        "<a-n>",
                        function()
                            Snacks.words.jump(vim.v.count1, true)
                        end,
                        has = "documentHighlight",
                        desc = "Next Reference",
                        enabled = function()
                            return Snacks.words.is_enabled()
                        end,
                    },
                    {
                        "<a-p>",
                        function()
                            Snacks.words.jump(-vim.v.count1, true)
                        end,
                        has = "documentHighlight",
                        desc = "Prev Reference",
                        enabled = function()
                            return Snacks.words.is_enabled()
                        end,
                    },
                },
            },
        },
    },
    config = function()
        vim.lsp.inlay_hint.enable(true, {})
        vim.lsp.codelens.enable(true)
        vim.diagnostic.config {
            float = {
                border = "rounded",
            },
            signs = {
                text = {
                    [vim.diagnostic.severity.ERROR] = "",
                    [vim.diagnostic.severity.HINT] = "󰌵",
                    [vim.diagnostic.severity.INFO] = "",
                    [vim.diagnostic.severity.WARN] = "",
                },
            },
            underline = true,
            update_in_insert = false,
            virtual_text = {
                spacing = 4,
                source = "if_many",
                prefix = "●",
            },
            severity_sort = true,
        }

        local servers = {
            "lua_ls",
            "html",
            "cssls",
            "ts_ls",
            "clangd",
            "neocmake",
            "qmlls",
            "pyright",
            "ruff",
            "bashls",
            "nixd",
            "dockerls",
            "marksman",
            "hyprls"
        }

        vim.lsp.enable(servers)

        vim.lsp.config("pyright", {
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

        vim.lsp.config("clangd", {
            keys = {
                { "<leader>lh", "<cmd>LspClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
            },
            root_markers = {
                "compile_commands.json",
                "compile_flags.txt",
                "configure.ac", -- AutoTools
                "Makefile",
                "configure.ac",
                "configure.in",
                "config.h.in",
                "meson.build",
                "meson_options.txt",
                "build.ninja",
                ".git",
            },
            capabilities = {
                offsetEncoding = { "utf-16" },
            },
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
                arguments = { vim.api.nvim_buf_get_name(0) },
            }
            vim.buf.execute_command(params)
        end

        vim.lsp.config("ts_ls", {
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

        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim", "Snacks" },
                    },
                    workspace = {
                        checkThirdParty = false,
                    },
                    codeLens = {
                        enable = true,
                    },
                    completion = {
                        callSnippet = "Replace",
                    },
                    doc = {
                        privateName = { "^_" },
                    },
                    hint = {
                        enable = true,
                        paramType = true,
                        arrayIndex = "Disable",
                    },
                },
            },
        })

        vim.lsp.config("nixd", {
            settings = {
                nixd = {
                    formatting = {
                        command = { "nixfmt" },
                    },
                },
            },
        })
    end,
}
