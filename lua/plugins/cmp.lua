return {
    "saghen/blink.cmp",
    version = "1.*",
    event = "InsertEnter",
    dependencies = {
        "rafamadriz/friendly-snippets",
        "bydlw98/blink-cmp-env",
        "Kaiser-Yang/blink-cmp-dictionary",
        "Kaiser-Yang/blink-cmp-git",
        "jdrupal-dev/css-vars.nvim",
        "erooke/blink-cmp-latex",
    },
    opts = {
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
        },
        cmdline = {
            enabled = true,
            keymap = { preset = "cmdline" },
            completion = {
                list = { selection = { preselect = true, auto_insert = true } },
                ghost_text = { enabled = true },
            },
        },
        completion = {
            menu = {
                border = "rounded",
                draw = {
                    columns = { { "kind_icon" }, { "label", gap = 1 }, { "label_description" }, { "kind" } },
                },
            },
            documentation = {
                auto_show = true,
                auto_show_delay_ms = 200,
                window = { border = "rounded" },
            },
        },
        signature = { enabled = true, window = { border = "rounded" } },
        sources = {
            -- Добавил css_vars в default, чтобы он работал
            default = { "latex", "git", "dictionary", "lsp", "path", "snippets", "buffer", "env", "css_vars" },
            providers = {
                env = { name = "Env", module = "blink-cmp-env" },
                dictionary = {
                    module = "blink-cmp-dictionary",
                    name = "Dict",
                    min_keyword_length = 3,
                },
                git = { module = "blink-cmp-git", name = "Git" },
                css_vars = {
                    name = "css-vars",
                    module = "css-vars.blink",
                    opts = { search_extensions = { ".js", ".ts", ".jsx", ".tsx" } },
                },
                latex = {
                    name = "Latex",
                    module = "blink-cmp-latex",
                    opts = { insert_command = false },
                },
            },
        },
        fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
}
