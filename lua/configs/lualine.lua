-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.

-- stylua: ignore
---@diagnostic disable: undefined-global
local g = vim.g
---@diagnostic enable: undefined-global

local colors = {}

if g.re_nvim_style == "catppuccin" then
    colors = {
        blue = "#80a0ff",
        cyan = "#a6e3a1",
        black = "#11111b",
        white = "#cdd6f4",
        red = "#f38ba8",
        violet = "#cba6f7",
        grey = "#1e1e2e",
    }
elseif g.re_nvim_style == "gruvbox" then
    colors = {
        blue = "#80a0ff",
        cyan = "#a6e3a1",
        black = "#11111b",
        white = "#cdd6f4",
        red = "#f38ba8",
        violet = "#cba6f7",
        grey = "#1e1e2e",
    }
elseif g.re_nvim_style == "touka" then
    colors = {
        blue = "#7aaaff",
        cyan = "#55b682",
        black = "#121214",
        white = "#e9ecf2",
        red = "#f25c5c",
        violet = "#f38ba8",
        grey = "#373740",
    }
else
    colors = {
        blue = "#80a0ff",
        cyan = "#a6e3a1",
        black = "#11111b",
        white = "#cdd6f4",
        red = "#f38ba8",
        violet = "#cba6f7",
        grey = "#1e1e2e",
    }
end

local bubbles_theme = {
    normal = {
        a = { fg = colors.black, bg = colors.blue },
        b = { fg = colors.white, bg = colors.grey },
        c = { fg = colors.white, bg = colors.black },
    },

    insert = { a = { fg = colors.black, bg = colors.violet } },
    visual = { a = { fg = colors.black, bg = colors.cyan } },
    replace = { a = { fg = colors.black, bg = colors.red } },

    inactive = {
        a = { fg = colors.white, bg = colors.grey },
        b = { fg = colors.white, bg = colors.grey },
        c = { fg = colors.white },
    },
}

require("lualine").setup {
    options = {
        theme = bubbles_theme,
        component_separators = "",
        section_separators = { right = "", left = "" },
    },
    sections = {
        lualine_a = { { "mode", separator = { left = "" }, right_padding = 2 } },
        lualine_b = { "filename", "branch" },
        lualine_c = {
            "%=", --[[ add your center compoentnts here in place of this comment ]]
        },
        lualine_x = {},
        lualine_y = { "filetype", "progress" },
        lualine_z = {
            { "location", separator = { right = "" }, left_padding = 2 },
        },
    },
    inactive_sections = {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "location" },
    },
    tabline = {},
    extensions = {},
}
