---@diagnostic disable: undefined-global
local map = vim.keymap.set
---@diagnostic enable: undefined-global

local builtin = require "telescope.builtin"

require("telescope").setup {
    -- FILES
    map("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" }),
    map("n", "<leader>fw", builtin.live_grep, { desc = "Telescope live grep" }),
    map("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" }),
    map("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" }),

    -- LSP
    map("n", "<leader>fr", builtin.lsp_references, { desc = "Telescope LSP references" }),
    map("n", "<leader>fg", builtin.lsp_incoming_calls, { desc = "Telescope LSP incoming calls" }),

    map(
        "n",
        "<leader>fz",
        "<cmd>Telescope current_buffer_fuzzy_find<CR>",
        { desc = "Telescope find in current buffer" }
    ),
    map("n", "<leader>cm", builtin.git_commits, { desc = "Telescope git commits" }),
    map("n", "<leader>gt", builtin.git_status, { desc = "Telescope git status" }),

    defaults = {
        mappings = {
            n = {
                ["q"] = require("telescope.actions").close,
            },
            i = {
                ["<C-h>"] = "which_key",
            },
        },
    },
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown {},
        },
    },
}
require("telescope").load_extension "ui-select"
