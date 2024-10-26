-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.base46 = {
  -- THEME SETTINGS
  theme = "catppuccin",
  theme_toggle = { "catppuccin", "github_light" },
  transparency = true,

  -- HILIGHT SETTINGS
  hl_add = {
    WinBar = { bg = "NONE" },
    WinBarNC = { bg = "NONE" },
  },
  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
    TbBufOn = { italic = true, fg = "red" },
    TelescopeSelection = { italic = true },
  },
  integrations = {},
}
M.ui = {
  -- CMP(CODE TIPS) SETTINGS
  cmp = {
    -- icons = true,
    icons_left = true,
    lspkind_text = true,
    style = "default", -- default/flat_light/flat_dark/atom/atom_colored
    format_colors = {
      tailwind = false, -- will work for css lsp too
      icon = "󱓻",
    },
    border_color = "blue",
    selected_item_bg = "colored",
  },

  -- TELESCOPE SETTINGS
  telescope = { style = "bordered" }, -- borderless / bordered

  ------------------------------- nvchad_ui modules -----------------------------
  statusline = {
    theme = "minimal", -- default/vscode/vscode_colored/minimal
    -- default/round/block/arrow separators work only for default statusline theme
    -- round and block will work for minimal theme only
    separator_style = "round",
    order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cwd", "cursor" },
    modules = nil,
  },
  tabufline = {
    enabled = true,
    lazyload = false,
    order = { "treeOffset", "buffers", "tabs", "btns" },
    modules = nil,
  },
  lsp = { signature = true },
  cheatsheet = {
    theme = "grid", -- simple/grid
    excluded_groups = { "terminal (t)", "autopairs", "Nvim", "Opens" }, -- can add group name or with mode
  },
}

-- nvdash (dashboard)
M.nvdash = {
  load_on_startup = false,
  -- select you favorite dash :3
  header = {
    -- "███╗  ██╗███████╗ █████╗ ██╗   ██╗██╗███╗   ███╗",
    -- "████╗ ██║██╔════╝██╔══██╗██║   ██║██║████╗ ████║",
    -- "██╔██╗██║█████╗  ██║  ██║╚██╗ ██╔╝██║██╔████╔██║",
    -- "██║╚████║██╔══╝  ██║  ██║ ╚████╔╝ ██║██║╚██╔╝██║",
    -- "██║ ╚███║███████╗╚█████╔╝  ╚██╔╝  ██║██║ ╚═╝ ██║",
    -- "╚═╝  ╚══╝╚══════╝ ╚════╝    ╚═╝   ╚═╝╚═╝     ╚═╝",
    -- "                                                ",
    -- "██████╗ ███████╗   ███╗   ██╗██╗   ██╗██╗███╗   ███╗",
    -- "██╔══██╗██╔════╝██╗████╗  ██║██║   ██║██║████╗ ████║",
    -- "██████╔╝█████╗  ╚═╝██╔██╗ ██║██║   ██║██║██╔████╔██║",
    -- "██╔══██╗██╔══╝  ██╗██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║",
    -- "██║  ██║███████╗╚═╝██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║",
    -- "╚═╝  ╚═╝╚══════╝   ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝",
    --
    " ██▀███  ▓█████ ▒▓▒  ███▄    █ ██▒   █▓ ██▓ ███▄ ▄███▓",
    "▓██ ▒ ██▒▓█   ▀  ▒   ██ ▀█   █▓██░   █▒▓██▒▓██▒▀█▀ ██▒",
    "▓██ ░▄█ ▒▒███       ▓██  ▀█ ██▒▓██  █▒░▒██▒▓██    ▓██░",
    "▒██▀▀█▄  ▒▓█  ▄ ▒▓▒ ▓██▒  ▐▌██▒ ▒██ █░░░██░▒██    ▒██ ",
    "░██▓ ▒██▒░▒████ ░▒  ▒██░   ▓██░  ▒▀█░  ░██░▒██▒   ░██▒",
    "░ ▒▓ ░▒▓░░░ ▒░  ░   ░ ▒░   ▒ ▒   ░ ▐░  ░▓  ░ ▒░   ░  ░",
    "  ░▒ ░ ▒░ ░ ░    ░  ░ ░░   ░ ▒░  ░ ░░   ▒ ░░  ░      ░",
    "  ░░   ░    ░    ░     ░   ░ ░     ░░   ▒ ░░      ░   ",
    "   ░        ░                ░      ░   ░         ░   ",
    "                                   ░                  ",
    "                                                      ",
    "                    𝓑𝔂 𝓡𝓮𝓢𝓽𝓻𝓪𝓷𝓰𝓮𝓻                     ",
  },

  buttons = {
    { txt = "  Find File", keys = "Spc f f", cmd = "Telescope find_files" },
    { txt = "  Recent Files", keys = "Spc f o", cmd = "Telescope oldfiles" },
    { txt = "󰈭  Find Word", keys = "Spc f w", cmd = "Telescope live_grep" },
    { txt = "  Bookmarks", keys = "Spc m a", cmd = "Telescope marks" },
    { txt = "󱥚  Themes", keys = "Spc t h", cmd = ":lua require('nvchad.themes').open()" },
    { txt = "  Mappings", keys = "Spc c h", cmd = "NvCheatsheet" },
    { txt = "─", hl = "NvDashLazy", no_gap = true, rep = true },
    {
      txt = function()
        local stats = require("lazy").stats()
        local ms = math.floor(stats.startuptime) .. " ms"
        return "  Loaded " .. stats.loaded .. "/" .. stats.count .. " plugins in " .. ms
      end,
      hl = "NvDashLazy",
      no_gap = true,
    },
    { txt = "─", hl = "NvDashLazy", no_gap = true, rep = true },
  },
}
M.term = {
  hl = "Normal:term,WinSeparator:WinSeparator",
  winopts = { number = false, relativenumber = false },
  sizes = { sp = 0.3, vsp = 0.2, ["bo sp"] = 0.3, ["bo vsp"] = 0.2 },
  float = {
    relative = "editor",
    row = 0.3,
    col = 0.25,
    width = 0.5,
    height = 0.4,
    border = "single",
  },
}

return M
