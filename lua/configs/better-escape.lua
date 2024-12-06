local api = vim.api
local schedule = vim.schedule

require("better_escape").setup({
  timeout = 200,
  default_mappings = false,
  mappings = {
    i = { j = { j = "<Esc>", }, [ "о" ] = { [ "о" ] = "<esc>", } },
    c = { j = { j = "<Esc>", } },
    t = { j = { j = "<C-\\><C-n>", } },
    v = { j = { ["<leader>"] = "<Esc>", } },
    s = {},
  }
})
