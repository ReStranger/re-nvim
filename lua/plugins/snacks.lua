return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
        bigfile = { enabled = true },
        dashboard = {
            enabled = true,

            preset = {
                header = [[
 ██▀███  ▓█████ ▒▓▒  ███▄    █ ██▒   █▓ ██▓ ███▄ ▄███▓
▓██ ▒ ██▒▓█   ▀  ▒   ██ ▀█   █▓██░   █▒▓██▒▓██▒▀█▀ ██▒
▓██ ░▄█ ▒▒███       ▓██  ▀█ ██▒▓██  █▒░▒██▒▓██    ▓██░
▒██▀▀█▄  ▒▓█  ▄ ▒▓▒ ▓██▒  ▐▌██▒ ▒██ █░░░██░▒██    ▒██ 
░██▓ ▒██▒░▒████ ░▒  ▒██░   ▓██░  ▒▀█░  ░██░▒██▒   ░██▒
░ ▒▓ ░▒▓░░░ ▒░  ░   ░ ▒░   ▒ ▒   ░ ▐░  ░▓  ░ ▒░   ░  ░
  ░▒ ░ ▒░ ░ ░    ░  ░ ░░   ░ ▒░  ░ ░░   ▒ ░░  ░      ░
  ░░   ░    ░    ░     ░   ░ ░     ░░   ▒ ░░      ░   
   ░        ░                ░      ░   ░         ░   
 ]],
        -- stylua: ignore
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "w", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
            },
        },
        explorer = { enabled = false },
        image = { enabled = true },
        indent = { enabled = true },
        input = { enabled = true },
        notifier = { enabled = false },
        picker = { enabled = false },
        quickfile = { enabled = true },
        scope = { enabled = true },
        scroll = { enabled = true },
        statuscolumn = { enabled = true },
        terminal = {},
        words = { enabled = true },
    },
    keys = {
        {
            "<leader>ol",
            function()
                Snacks.lazygit()
            end,
            desc = "File Explorer",
        },
        {
            "<leader>ot",
            function()
                Snacks.terminal()
            end,
            desc = "File Terminal",
        },
    },
}
