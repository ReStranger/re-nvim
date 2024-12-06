require("lazy").setup({
  {
    "nvim-neo-tree/neo-tree.nvim",
		cmp = { "Neotree float toggle", "Neotree left toggle" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      "s1n7ax/nvim-window-picker",
    },
		config = function()
			require("configs.neo-tree")
		end,
  },
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
		build = ":TSUpdate",
			config = function()
				require("configs.nvim-treesitter")
			end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			require("configs.nvim-lspconfig")
		end,
	},
})
