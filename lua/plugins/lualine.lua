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

        local function get_stylix_colors()
            local palette_path = os.getenv "HOME" .. "/.config/stylix/palette.json"
            local palette_file = io.open(palette_path, "r")
            if not palette_file then
                return nil
            end
            local content = palette_file:read "*a"
            palette_file:close()
            local ok, palette = pcall(vim.json.decode, content)
            if not ok or not palette then
                return nil
            end
            return {
                black = "#" .. (palette.base00 or "121214"),
                bg_mid = "#" .. (palette.base01 or "212126"),
                gray = "#" .. (palette.base03 or "373740"),
                silver = "#" .. (palette.base05 or "e9ecf2"),
                red = "#" .. (palette.base08 or "f25c5c"),
                orange = "#" .. (palette.base09 or "ff9c6a"),
                green = "#" .. (palette.base0B or "55b682"),
                blue = "#" .. (palette.base0C or "7aaaff"),
                magenta = "#" .. (palette.base0D or "f17ac6"),
                purple = "#" .. (palette.base0E or "b87aff"),
            }
        end

        local stylix_colors = get_stylix_colors()

        local theme = stylix_colors
            and {
                normal = {
                    a = { fg = stylix_colors.black, bg = stylix_colors.blue, gui = "bold" },
                    b = { fg = stylix_colors.white, bg = stylix_colors.gray },
                    c = { fg = stylix_colors.silver, bg = stylix_colors.black },
                },
                insert = { a = { fg = stylix_colors.black, bg = stylix_colors.green, gui = "bold" } },
                visual = { a = { fg = stylix_colors.black, bg = stylix_colors.purple, gui = "bold" } },
                replace = { a = { fg = stylix_colors.black, bg = stylix_colors.red, gui = "bold" } },
                inactive = {
                    a = { fg = stylix_colors.silver, bg = stylix_colors.gray, gui = "bold" },
                    b = { fg = stylix_colors.gray, bg = stylix_colors.black },
                    c = { fg = stylix_colors.silver, bg = stylix_colors.black },
                },
            }

        local opts = {
            options = {
                theme = theme or "auto",
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
