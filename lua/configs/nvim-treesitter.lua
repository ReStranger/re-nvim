require'nvim-treesitter.configs'.setup {
  ensure_installed = { "lua" },

  sync_install = true,

  auto_install = false,

  highlight = {
    enable = true,
  },
}
