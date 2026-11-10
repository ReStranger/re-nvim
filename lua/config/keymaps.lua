-- System
Snacks.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Global yank" })

-- Windows
local resize_step = 2

local function resize_split(direction)
    local cur = vim.fn.winnr()
    local has_right = vim.fn.winnr("l") ~= cur
    local has_down = vim.fn.winnr("j") ~= cur

    if direction == "h" then
        vim.cmd(("vertical resize %+d"):format(has_right and -resize_step or resize_step))
    elseif direction == "j" then
        vim.cmd(("resize %+d"):format(has_down and resize_step or -resize_step))
    elseif direction == "k" then
        vim.cmd(("resize %+d"):format(has_down and -resize_step or resize_step))
    elseif direction == "l" then
        vim.cmd(("vertical resize %+d"):format(has_right and resize_step or -resize_step))
    end
end

Snacks.keymap.set("n", "<leader>ws", "<C-w>s", { desc = "Window horizontal split" })
Snacks.keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Window vertical split" })
Snacks.keymap.set("n", "<leader>wh", "<C-w>h", { desc = "Window left" })
Snacks.keymap.set("n", "<leader>wj", "<C-w>j", { desc = "Window down" })
Snacks.keymap.set("n", "<leader>wk", "<C-w>k", { desc = "Window up" })
Snacks.keymap.set("n", "<leader>wl", "<C-w>l", { desc = "Window right" })
Snacks.keymap.set("n", "<leader>wx", "<C-w>c", { desc = "Window close" })
Snacks.keymap.set("n", "<leader>wo", "<C-w>o", { desc = "Window only" })
Snacks.keymap.set("n", "<leader>w=", "<C-w>=", { desc = "Window equalize" })
Snacks.keymap.set("n", "<A-h>", function()
    resize_split("h")
end, { desc = "Move split left" })
Snacks.keymap.set("n", "<A-j>", function()
    resize_split("j")
end, { desc = "Move split down" })
Snacks.keymap.set("n", "<A-k>", function()
    resize_split("k")
end, { desc = "Move split up" })
Snacks.keymap.set("n", "<A-l>", function()
    resize_split("l")
end, { desc = "Move split right" })

Snacks.keymap.set("n", "<leader>x", function()
    Snacks.bufdelete()
end, { desc = "Buffer close" })

-- Tmux
Snacks.keymap.set("n", "<c-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "Tmux Left" })
Snacks.keymap.set("n", "<c-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "Tmux Down" })
Snacks.keymap.set("n", "<c-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "Tmux Up" })
Snacks.keymap.set("n", "<c-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "Tmux Right" })
Snacks.keymap.set("n", "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>", { desc = "Tmux Previous" })

-- NeoTree
Snacks.keymap.set("n", "<leader>i", "<cmd>Neotree float toggle<CR>", { desc = "Neotree toggle float" })
Snacks.keymap.set("n", "<c-n>", "<cmd>Neotree left toggle<CR>", { desc = "Neotree toggle left" })

-- Profiler
Snacks.toggle.profiler():map "<leader>pp"
Snacks.toggle.profiler_highlights():map "<leader>ph"
