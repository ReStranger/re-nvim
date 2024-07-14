-- This file  needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/NvChad/blob/v2.5/lua/nvconfig.lua

---@type ChadrcConfig
local M = {}

M.ui = {
  ------------------------------- base46 -------------------------------------

  -- THEME SETTINGS
  theme = "catppuccin",
  theme_toggle = { "catppuccin", "github_light" },
  transparency = true,

  -- HILIGHT SETTINGS
  hl_add = {},
  hl_override = {
    Comment = { italic = true },
    ["@comment"] = { italic = true },
  },

  -- CMP(CODE TIPS) SETTINGS
  cmp = {
    icons = true,
    lspkind_text = true,
    style = "default", -- default/flat_light/flat_dark/atom/atom_colored
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
    separator_style = "block",
    order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cwd", "cursor" },
    modules = nil,
  },
  tabufline = {
    enabled = true,
    lazyload = true,
    order = { "treeOffset", "buffers", "tabs", "btns" },
    modules = nil,
  },
  -- nvdash (dashboard)
  nvdash = {
    load_on_startup = true,
    header = {
      "███╗  ██╗███████╗ █████╗ ██╗   ██╗██╗███╗   ███╗",
      "████╗ ██║██╔════╝██╔══██╗██║   ██║██║████╗ ████║",
      "██╔██╗██║█████╗  ██║  ██║╚██╗ ██╔╝██║██╔████╔██║",
      "██║╚████║██╔══╝  ██║  ██║ ╚████╔╝ ██║██║╚██╔╝██║",
      "██║ ╚███║███████╗╚█████╔╝  ╚██╔╝  ██║██║ ╚═╝ ██║",
      "╚═╝  ╚══╝╚══════╝ ╚════╝    ╚═╝   ╚═╝╚═╝     ╚═╝",
      "                                                ",
      "                 𝓑𝔂 𝓡𝓮𝓢𝓽𝓻𝓪𝓷𝓰𝓮𝓻                  ",
    },

    buttons = {
      { "  Find File", "Spc f f", "Telescope find_files" },
      { "󰈚  Recent Files", "Spc f o", "Telescope oldfiles" },
      { "󰈭  Find Word", "Spc f w", "Telescope live_grep" },
      { "  Bookmarks", "Spc m a", "Telescope marks" },
      { "  Themes", "Spc t h", "Telescope themes" },
      { "  Mappings", "Spc c h", "NvCheatsheet" },
    },
  },
  lsp = { signature = true },

  term = {
    hl = "Normal:term,WinSeparator:WinSeparator",
    sizes = { sp = 0.3, vsp = 0.2 },
    float = {
      relative = "editor",
      row = 0.3,
      col = 0.25,
      width = 0.5,
      height = 0.4,
      border = "single",
    },
  },
}
M.base46 = {
  integrations = {},
}
return M
