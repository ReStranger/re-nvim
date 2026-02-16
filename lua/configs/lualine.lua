-- Bubbles config for lualine
-- Author: lokesh-krishna
-- MIT license, see LICENSE for more details.

-- stylua: ignore
---@diagnostic disable: undefined-global
local g = vim.g
---@diagnostic enable: undefined-global

local colors = {}

if g.re_nvim_theme == "catppuccin" then
    colors = {
        blue = "#80a0ff",
        cyan = "#a6e3a1",
        black = "#11111b",
        white = "#cdd6f4",
        red = "#f38ba8",
        violet = "#cba6f7",
        grey = "#1e1e2e",
    }
elseif g.re_nvim_theme == "gruvbox" then
    colors = {
        blue = "#8ec07c",
        cyan = "#b8bb26",
        black = "#1d2021",
        white = "#ebdbb2",
        red = "#fb4934",
        violet = "#83a598",
        grey = "#665c54",
    }
elseif g.re_nvim_theme == "touka" then
    colors = {
        blue = "#7aaaff",
        cyan = "#55b682",
        black = "#121214",
        white = "#e9ecf2",
        red = "#f25c5c",
        violet = "#f17ac6",
        grey = "#212126",
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
local separator = {
    round = { left = "", right = "" },
    square = { left = "", right = "" },
    title = { left = "", right = "" },
}

-- Определяем стиль разделителей (по умолчанию round)
local border_style = g.re_nvim_border_style or "round"
-- Определяем стиль разделителей секций (по умолчанию round)
local separator_style = g.re_nvim_lualine_separator or "round"

local sections = {
    rounded = {
        lualine_a = {
            {
                "mode",
                separator = {
                    left = separator["round"].left,
                    right = separator[separator_style].right,
                },
            },
        },
        lualine_b = { "filename", "branch" },
        lualine_c = {
            "%=", --[[ add your center components here in place of this comment ]]
        },
        lualine_x = {},
        lualine_y = { "filetype", "progress" },
        lualine_z = {
            { "location", separator = { left = separator[separator_style].left, right = separator["round"].right } },
        },
    },
    square = {
        lualine_a = {
            {
                "mode",
                separator = {
                    left = separator["square"].left,
                    right = separator[separator_style].right,
                },
            },
        },
        lualine_b = { "filename", "branch" },
        lualine_c = {
            "%=", --[[ add your center components here in place of this comment ]]
        },
        lualine_x = {},
        lualine_y = { "filetype", "progress" },
        lualine_z = {
            { "location", separator = { left = separator[separator_style].left, right = separator["square"].right } },
        },
    },
}

local section_separators = {
    rounded = {
        right = separator["round"].left,
        left = separator["round"].right,
    },
    square = {
        right = separator["square"].left,
        left = separator["square"].right,
    },
}

require("lualine").setup {
    options = {
        theme = bubbles_theme,
        component_separators = "",
        section_separators = {
            left = section_separators[border_style].left,
            right = section_separators[border_style].right,
        },
    },
    sections = sections[border_style],
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
