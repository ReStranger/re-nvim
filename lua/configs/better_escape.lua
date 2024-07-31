require("better_escape").setup {
  timeout = vim.o.timeoutlen,
  mappings = {
    i = {
      j = {
        j = "<Esc>",
      },
    },
    v = {
      j = {
        v = "{Esc}",
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
