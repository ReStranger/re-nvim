require("better_escape").setup {
  timeout = vim.o.timeoutlen,
  mappings = {
    i = {
      j = {
        j = "<Esc>",
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
    v = {
      j = {
        k = "<Esc>",
      },
    },
    s = {
      j = {
        j = "<Esc>",
      },
    },
  },
}
