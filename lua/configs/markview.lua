---@diagnostic disable: undefined-global
local g = vim.g
---@diagnostic enable: undefined-global

require("markview").setup {
    html = {
        enable = true,
    },

    latex = {
        enable = true,
        blocks = {
            enable = true,
        },
        inlines = {
            enable = true,
        },

        commands = {},
        escapes = {},
        parenthesis = {},
    },

    markdown = {
        enable = true,
        horizontal_rules = require("markview.presets").horizontal_rules.thin,
        tables = (function()
            if g.re_nvim_border_style == "none" then
                return require("markview.presets").tables.none
            elseif g.re_nvim_border_style == "square" then
                return require("markview.presets").tables.single
            else
                return require("markview.presets").tables.rounded
            end
        end)(),
    },
    markdown_inline = {
        enable = true,
    },
    preview = {
        enable = true,
        enable_hybrid_mode = true,
        icon_provider = "devicons",
        filetypes = { "markdown", "markdown_inline", "codecompanion", "latex", "html" },
        ignore_buftypes = {},
    },
    typst = { enable = false },
    yaml = { enable = true },

    comment = {
        enable = true,
    },
}
