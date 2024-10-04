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
    order = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "AI", "cwd", "cursor" },
    modules = {
      AI = function()
        local ai_status = vim.api.nvim_call_function("codeium#GetStatusString", {})
        return "󰚩" .. ai_status .. " "
      end,
    },
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
  cheatsheet = {
    theme = "grid", -- simple/grid
    excluded_groups = { "terminal (t)", "autopairs", "Nvim", "Opens" }, -- can add group name or with mode
  },

  term = {
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
  },
}
return M
