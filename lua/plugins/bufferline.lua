return {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
        { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
        { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
        { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
        { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
        { "<Tab>", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
        { "<S-Tab>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
        { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move buffer prev" },
        { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move buffer next" },
        { "<leader>bj", "<cmd>BufferLinePick<cr>", desc = "Pick Buffer" },
    },
    opts = {
        options = {
      -- stylua: ignore
      close_command = function(n) Snacks.bufdelete(n) end,
      -- stylua: ignore
      right_mouse_command = function(n) Snacks.bufdelete(n) end,
            diagnostics = "nvim_lsp",
            always_show_bufferline = false,
            diagnostics_indicator = function(count, level, _, _)
                local icon = level:match "error" and " " or " "
                return " " .. icon .. count
            end,

            offsets = {
                {
                    filetype = "neo-tree",
                    text = " File Explorer",
                    highlight = "Directory",
                    text_align = "left",
                    separator = true,
                },
                {
                    filetype = "snacks_layout_box",
                },
            },
        },
    },
    config = function(_, opts)
        require("bufferline").setup(opts)
        -- Fix bufferline when restoring a session
        vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
            callback = function()
                vim.schedule(function()
                    pcall(vim.fn.nvim_bufferline)
                end)
            end,
        })
    end,
}
