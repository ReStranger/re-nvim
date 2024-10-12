require("flirt").setup {
  override_open = true, -- experimental
  close_command = "Q",
  default_move_mappings = false, -- <C-arrows> to move floats
  default_resize_mappings = false, -- <A-arrows> to resize floats
  default_mouse_mappings = false, -- Drag floats with mouse
  exclude_fts = { "notify", "cmp_menu" },
  speed = 95, -- Can vary from 1 to 100 (100 is fast)
  custom_filter = function(buffer, win_config)
    return vim.bo[buffer].filetype == "cmp_menu" -- avoids animation
  end,
  -- more options on the way.
}
