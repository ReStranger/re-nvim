-- System
Snacks.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Global yank" })

Snacks.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Switch window left" })
Snacks.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Switch window right" })
Snacks.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Switch window down" })
Snacks.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Switch window up" })

Snacks.keymap.set("n", "<leader>v", "<cmd>split<CR>", { desc = "Window horizontal split" })
Snacks.keymap.set("n", "<leader>b", "<cmd>vsplit<CR>", { desc = "Window vertical split" })
Snacks.keymap.set("n", "<leader>x", function()
    Snacks.bufdelete()
end, { desc = "Window close" })

-- Tmux
Snacks.keymap.set("n", "<c-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "Tmux Left" })
Snacks.keymap.set("n", "<c-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "Tmux Down" })
Snacks.keymap.set("n", "<c-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "Tmux Up" })
Snacks.keymap.set("n", "<c-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "Tmux Right" })
Snacks.keymap.set("n", "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>", { desc = "Tmux Previous" })

-- NeoTree
Snacks.keymap.set("n", "<leader>i", "<cmd>Neotree float toggle<CR>", { desc = "Neotree toggle float" })
Snacks.keymap.set("n", "<c-n>", "<cmd>Neotree left toggle<CR>", { desc = "Neotree toggle left" })
