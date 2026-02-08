---@diagnostic disable: undefined-global
local g = vim.g
---@diagnostic enable: undefined-global

local border = "rounded"
if g.re_nvim_border_style == "none" then
    border = "none"
elseif g.re_nvim_border_style == "square" then
    border = "single"
end

return {
    keymap = {
        preset = "enter",
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<C-u>"] = { "scroll_signature_up", "fallback" },
        ["<C-d>"] = { "scroll_signature_down", "fallback" },
    },

    appearance = {
        use_nvim_cmp_as_default = false,
        nerd_font_variant = "mono",
        kind_icons = {
            Text = "",
            Method = "󰆧",
            Function = "󰊕",
            Constructor = "",
            Field = "󰇽",
            Variable = "󰂡",
            Class = "󰠱",
            Interface = "",
            Module = "",
            Property = "󰜢",
            Unit = "",
            Value = "󰎠",
            Enum = "",
            Keyword = "󰌋",
            Snippet = "",
            Color = "󰏘",
            File = "󰈙",
            Reference = "",
            Folder = "󰉋",
            EnumMember = "",
            Constant = "󰏿",
            Struct = "",
            Event = "",
            Operator = "󰆕",
            TypeParameter = "󰅲",
        },
    },
    cmdline = {
        enabled = true,

        keymap = { preset = "cmdline" },
        sources = { "buffer", "cmdline" },

        completion = {
            trigger = {
                show_on_blocked_trigger_characters = {},
                show_on_x_blocked_trigger_characters = {},
            },
            list = {
                selection = {
                    preselect = true,
                    auto_insert = true,
                },
            },
            menu = {
                auto_show = function(ctx, _)
                    return ctx.mode == "cmdwin"
                end,
            },
            ghost_text = { enabled = true },
        },
    },

    completion = {
        menu = {
            border = border,
            draw = {
                components = {},
                columns = {
                    { "kind_icon", gap = 1 },
                    { "label", gap = 1 },
                    { "label_description", "kind" },
                },
            },
        },
        documentation = {
            auto_show = false,
            window = { border = border },
        },
    },
    signature = { enabled = true, window = { border = border } },

    sources = {
        default = { "latex", "git", "dictionary", "lsp", "path", "snippets", "buffer", "env" },
        providers = {
            env = {
                name = "Env",
                module = "blink-cmp-env",
                opts = {
                    show_braces = false,
                    show_documentation_window = true,
                },
            },
            dictionary = {
                module = "blink-cmp-dictionary",
                name = "Dict",
                min_keyword_length = 3,
            },
            git = {
                module = "blink-cmp-git",
                name = "Git",
            },
            css_vars = {
                name = "css-vars",
                module = "css-vars.blink",
                opts = {
                    search_extensions = { ".js", ".ts", ".jsx", ".tsx" },
                },
            },
            latex = {
                name = "Latex",
                module = "blink-cmp-latex",
                opts = {
                    insert_command = false,
                },
            },
        },
        per_filetype = {
            codecompanion = { "codecompanion" },
        },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
}
