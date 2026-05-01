return {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    config = function()
        vim.api.nvim_create_autocmd("LspAttach", {
            group = vim.api.nvim_create_augroup("UserLspConfig", {}),
            callback = function(ev)
                vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

                local opts = { buffer = ev.buf }
                local map = function(lhs, rhs, desc, mode)
                    vim.keymap.set(mode or "n", lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
                end

                map("gd", vim.lsp.buf.definition, "Goto Definition")
                map("gr", vim.lsp.buf.references, "References")
                map("gI", vim.lsp.buf.implementation, "Goto Implementation")
                map("gy", vim.lsp.buf.type_definition, "Goto T[y]pe Definition")
                map("gD", vim.lsp.buf.declaration, "Goto Declaration")
                map("K", vim.lsp.buf.hover, "Hover")
                map("gK", vim.lsp.buf.signature_help, "Signature Help")
                map("<c-k>", vim.lsp.buf.signature_help, "Signature Help", "i")
                map("<leader>la", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
                map("<leader>lc", vim.lsp.codelens.run, "Run Codelens", { "n", "x" })
                map("<leader>lC", vim.lsp.codelens.refresh, "Refresh & Display Codelens")
                map("<leader>lR", function() Snacks.rename.rename_file() end, "Rename File")
                map("<leader>lr", vim.lsp.buf.rename, "Rename")

                local client = vim.lsp.get_client_by_id(ev.data.client_id)
                if client and client.name == "clangd" then
                    map("<leader>lh", "<cmd>LspClangdSwitchSourceHeader<cr>", "Switch Source/Header (C/C++)")
                end
            end,
        })

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
            vim.lsp.buf.execute_command(params)
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
                        command = { "alejandra" },
                    },
                },
            },
        })
    end,
}
