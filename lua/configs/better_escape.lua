require("better_escape").setup {
  timeout = vim.o.timeoutlen,
  mappings = {
    i = {
      j = {
        j = "<Esc>",
      },
      о = {
        о = "<Esc>",
      },
    },
    c = {
      j = {
        j = "<Esc>",
      },
    },
    t = {
      j = {
        j = "<Esc>",
      },
    },
    s = {
      j = {
        j = "<Esc>",
      },
    },
  },
}
