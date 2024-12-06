local opt = vim.opt

opt.termguicolors = true
require("bufferline").setup({
  options = {
    hover = {
      enabled = true,
      delay = 200,
      reveal = {'close'}
    },
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match("error") and " " or " "
      return " " .. icon .. count
    end,
    offsets = {
      {
        filetype = "neo-tree",
        text = "File Explorer",
        highlight = "Directory",
        text_align = "left",
        separator = true,
      },
    },
  },
})
