local g = vim.g
local map = vim.keymap.set
local bo = vim.bo
local lsp = vim.lsp
local api = vim.api
local diagnostic = vim.diagnostic
local inspect = vim.inspect
g.mapleader = " "
g.maplocalleader = "\\"

map("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

map({ "n", "v" }, "<leader>y", '"+y', { desc = "Global yank" })

map("n", "<leader>v", "<cmd>split<CR>", { desc = "split" })
map("n", "<leader>b", "<cmd>vsplit<CR>", { desc = "vsplit" })
map("n", "<leader>x", "<cmd>bdelete<CR>", { desc = "vsplit" })

map("t", "<C-x>", "<C-\\><C-N>", { desc = "terminal escape terminal mode" })

-- Comment
map("n", "<leader>/", "gcc", { desc = "toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "toggle comment", remap = true })

-- TMUX
map("n", "<c-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "Tmux Left" })
map("n", "<c-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "Tmux Down" })
map("n", "<c-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "Tmux Up" })
map("n", "<c-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "Tmux Right" })
map("n", "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>", { desc = "Tmux Previous" })

-- BufferLine
map("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>")
map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>")

map("n", "<leader>tt", "<cmd>TransparentToggle<CR>", { desc = "Transparent Toggle" })

-- Neotree
map("n", "<leader>i", "<cmd>Neotree float toggle<CR>")
map("n", "<C-n>", "<cmd>Neotree left toggle<CR>")

-- LSP
map("n", "<leader>lD", diagnostic.open_float)
map("n", "[d", diagnostic.goto_prev)
map("n", "]d", diagnostic.goto_next)
map("n", "<leader>ld", diagnostic.setloclist)

-- Toggle Term
map("n", "<leader>h", "<cmd>ToggleTerm<CR>", { desc = "ToggleTerm" })

api.nvim_create_autocmd("LspAttach", {
    group = api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        local opts = { buffer = ev.buf }
        map("n", "gD", lsp.buf.declaration, opts)
        map("n", "gd", lsp.buf.definition, opts)
        map("n", "K", lsp.buf.hover, opts)
        map("n", "gi", lsp.buf.implementation, opts)
        map("n", "<C-k>", lsp.buf.signature_help, opts)

        map("n", "<space>sa", lsp.buf.add_workspace_folder, opts)
        map("n", "<space>sr", lsp.buf.remove_workspace_folder, opts)
        map("n", "<space>sl", function()
            print(inspect(lsp.lsp.buf.list_workspace_folders()))
        end, opts)

        map("n", "<leader>lr", lsp.buf.rename, opts)
        map({ "n", "v" }, "<leader>la", lsp.buf.code_action, opts)
        map("n", "gr", lsp.buf.references, opts)
        map("n", "<leafer>lf", function()
            lsp.buf.format { async = true }
        end, opts)
    end,
})

-- DAP
map("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>")
map("n", "<leader>dr", "<cmd>DapContinue<CR>")

map("n", "<leader>tx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Trouble Diagnostics" })
map("n", "<leader>tX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Trouble Buffer Diagnostics" })
map("n", "<leader>cs", "<cmd>Trouble diagnostics toggle focus=false<cr>", { desc = "Trouble Symbols" })
map(
    "n",
    "<leader>cl",
    "<cmd>Trouble diagnostics toggle focus=false win.position=right<cr>",
    { desc = "Trouble LSP Definitions / references / ..." }
)
map("n", "<leader>tL", "<cmd>Trouble loclist toggle<cr>", { desc = "Trouble Location List" })
map("n", "<leader>tQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Trouble Quickfix List" })
