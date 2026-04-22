return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    init = function()
        vim.g.lualine_laststatus = vim.o.laststatus
        if vim.fn.argc(-1) > 0 then
            vim.o.statusline = " "
        else
            vim.o.laststatus = 0
        end
    end,
    opts = function()
        local lualine_require = require "lualine_require"
        lualine_require.require = require

        vim.o.laststatus = vim.g.lualine_laststatus

        local colors = {
            black = "#121214", -- base00
            bg_mid = "#212126", -- base01
            gray = "#373740", -- base03
            silver = "#e9ecf2", -- base05
            red = "#f25c5c", -- base08
            orange = "#ff9c6a", -- base09
            green = "#55b682", -- base0B
            blue = "#7aaaff", -- base0C
            magenta = "#f17ac6", -- base0D
            purple = "#B87AFF", -- base0E
        }

        local theme = {
            normal = {
                a = { fg = colors.black, bg = colors.blue, gui = "bold" },
                b = { fg = colors.white, bg = colors.gray },
                c = { fg = colors.silver, bg = colors.black },
            },
            insert = { a = { fg = colors.black, bg = colors.green, gui = "bold" } },
            visual = { a = { fg = colors.black, bg = colors.purple, gui = "bold" } },
            replace = { a = { fg = colors.black, bg = colors.red, gui = "bold" } },
            inactive = {
                a = { fg = colors.silver, bg = colors.gray, gui = "bold" },
                b = { fg = colors.gray, bg = colors.black },
                c = { fg = colors.silver, bg = colors.black },
            },
        }

        local opts = {
            options = {
                theme = theme,
                globalstatus = vim.o.laststatus == 3,
                disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
            },
            sections = {
                lualine_a = { { "mode", padding = { left = 1, right = 0 } } },
                lualine_b = {
                    { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
                    { "filename", padding = { left = 0, right = 0 } },
                },
                lualine_c = {
                    { "branch", icon = "", padding = { left = 1, right = 0 } },
                    {
                        "diff",
                        symbols = {
                            added = " ",
                            modified = " ",
                            removed = " ",
                        },
                        source = function()
                            local gitsigns = vim.b.gitsigns_status_dict
                            if gitsigns then
                                return {
                                    added = gitsigns.added,
                                    modified = gitsigns.changed,
                                    removed = gitsigns.removed,
                                }
                            end
                        end,
                        padding = { left = 1, right = 0 },
                    },
                },
                lualine_x = {
                    Snacks.profiler.status(),
                    {
                        function()
                            return require("noice").api.status.command.get()
                        end,
                        cond = function()
                            return package.loaded["noice"] and require("noice").api.status.command.has()
                        end,
                        color = function()
                            return { fg = Snacks.util.color "Statement" }
                        end,
                    },
                    {
                        function()
                            return require("noice").api.status.mode.get()
                        end,
                        cond = function()
                            return package.loaded["noice"] and require("noice").api.status.mode.has()
                        end,
                        color = function()
                            return { fg = Snacks.util.color "Constant" }
                        end,
                    },
                    {
                        function()
                            return "  " .. require("dap").status()
                        end,
                        cond = function()
                            return package.loaded["dap"] and require("dap").status() ~= ""
                        end,
                        color = function()
                            return { fg = Snacks.util.color "Debug" }
                        end,
                    },
                    {
                        require("lazy.status").updates,
                        cond = require("lazy.status").has_updates,
                        color = function()
                            return { fg = Snacks.util.color "Special" }
                        end,
                    },
                    {
                        "diagnostics",
                        symbols = {
                            error = " ",
                            hint = "󰌵 ",
                            info = " ",
                            warn = " ",
                        },
                    },
                    {
                        function()
                            local clients = vim.lsp.get_clients { bufnr = 0 }
                            if #clients == 0 then
                                return "󱏎 "
                            end
                            local names = {}
                            for _, client in ipairs(clients) do
                                table.insert(names, client.name)
                            end
                            return "  " .. table.concat(names, ", ")
                        end,
                        cond = function()
                            local clients = vim.lsp.get_clients { bufnr = 0 }
                            return #clients > 0
                        end,
                        color = function()
                            return { fg = Snacks.util.color "Special" }
                        end,
                    },
                },
                lualine_y = {
                    {
                        function()
                            local clients = vim.lsp.get_clients { bufnr = 0 }
                            local root = (clients[1] and clients[1].config.root_dir) or vim.fn.getcwd()
                            return "󰉋 " .. vim.fn.fnamemodify(root, ":t")
                        end,
                        padding = { left = 0, right = 1 },
                    },
                },
                lualine_z = {
                    { "progress" },
                },
            },
            extensions = { "neo-tree", "lazy", "fzf" },
        }

        local trouble = require "trouble"
        local symbols = trouble.statusline {
            mode = "symbols",
            groups = {},
            title = false,
            filter = { range = true },
            format = "{kind_icon}{symbol.name:Normal}",
            hl_group = "lualine_c_normal",
        }
        table.insert(opts.sections.lualine_c, {
            symbols and symbols.get,
            cond = function()
                return vim.b.trouble_lualine ~= false and symbols.has()
            end,
        })

        return opts
    end,
}
