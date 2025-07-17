---@diagnostic disable: undefined-global
local api = vim.api
local bo = vim.bo
local diagnostic = vim.diagnostic
local fn = vim.fn
local g = vim.g
local inspect = vim.inspect
local lsp = vim.lsp
local map = vim.keymap.set
---@diagnostic enable: undefined-global

g.mapleader = " "
g.maplocalleader = "\\"

map("n", "<C-h>", "<C-w>h", { desc = "Switch window left" })
map("n", "<C-l>", "<C-w>l", { desc = "Switch window right" })
map("n", "<C-j>", "<C-w>j", { desc = "Switch window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Switch window up" })

map({ "n", "v" }, "<leader>y", '"+y', { desc = "Global yank" })

map("n", "<leader>v", "<cmd>split<CR>", { desc = "Window horizontal split" })
map("n", "<leader>b", "<cmd>vsplit<CR>", { desc = "Window vertical split" })
map("n", "<leader>x", "<cmd>bdelete<CR>", { desc = "Window close" })

map("t", "<C-x>", "<C-\\><C-N>", { desc = "Escape terminal mode" })

-- Comment
map("n", "<leader>/", "gcc", { desc = "Toggle comment", remap = true })
map("v", "<leader>/", "gc", { desc = "Toggle comment", remap = true })

-- TMUX
map("n", "<c-h>", "<cmd>TmuxNavigateLeft<cr>", { desc = "Tmux Left" })
map("n", "<c-j>", "<cmd>TmuxNavigateDown<cr>", { desc = "Tmux Down" })
map("n", "<c-k>", "<cmd>TmuxNavigateUp<cr>", { desc = "Tmux Up" })
map("n", "<c-l>", "<cmd>TmuxNavigateRight<cr>", { desc = "Tmux Right" })
map("n", "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>", { desc = "Tmux Previous" })

-- BufferLine
map("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Buffer next" })
map("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Buffer prev" })
map("n", "gt", "<cmd>BufferLineCycleNext<CR>", { desc = "Buffer next" })
map("n", "gT", "<cmd>BufferLineCyclePrev<CR>", { desc = "Buffer prev" })

map("n", "<leader>tt", "<cmd>TransparentToggle<CR>", { desc = "Transparent Toggle" })

-- Neotree
map("n", "<leader>i", "<cmd>Neotree float toggle<CR>", { desc = "Neotree toggle float" })
map("n", "<C-n>", "<cmd>Neotree left toggle<CR>", { desc = "Neotree toggle left" })

-- LSP
map("n", "<leader>lD", diagnostic.open_float, { desc = "LSP Open float diagnostic" })
map("n", "[d", diagnostic.goto_prev, { desc = "LSP Goto prev diagnostic" })
map("n", "]d", diagnostic.goto_next, { desc = "LSP Goto prev diagnostic" })
map("n", "<leader>ld", diagnostic.setloclist, { desc = "LSP Diagnostic list" })

-- Toggle Term
map("n", "<leader>hh", "<cmd>ToggleTerm<CR>", { desc = "Toggle terminal" })
map("n", "<leader>hf", "<cmd>ToggleTerm direction=float<CR>", { desc = "Toggle floating terminal" })

api.nvim_create_autocmd("LspAttach", {
    group = api.nvim_create_augroup("UserLspConfig", {}),
    callback = function(ev)
        bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

        local opts = { buffer = ev.buf }
        map("n", "gD", lsp.buf.declaration, opts, { desc = "LSP Go to declaration" })
        map("n", "gd", lsp.buf.definition, opts, { desc = "LSP Go to definition" })
        map("n", "K", lsp.buf.hover, opts, { desc = "LSP Show hover" })
        map("n", "gi", lsp.buf.implementation, opts, { desc = "LSP Go to implementation" })
        map("n", "<C-k>", lsp.buf.signature_help, opts, { desc = "LSP Show signature help" })

        map("n", "<space>sa", lsp.buf.add_workspace_folder, opts, { desc = "LSP Add workspace folder" })
        map("n", "<space>sr", lsp.buf.remove_workspace_folder, opts, { desc = "LSP Remove workspace folder" })
        map("n", "<space>sl", function()
            print(inspect(lsp.lsp.buf.list_workspace_folders()))
        end, opts, { desc = "LSP Show signature help" })

        map("n", "<leader>lr", lsp.buf.rename, opts, { desc = "LSP Rename" })
        map({ "n", "v" }, "<leader>la", lsp.buf.code_action, opts, { desc = "LSP Code actions" })
        map("n", "gr", lsp.buf.references, opts, { desc = "LSP Buffer references" })
        map("n", "<leafer>lf", function()
            lsp.buf.format { async = true }
        end, opts, { desc = "LSP Buffer format" })
    end,
})
map("n", "<leader>lf", function()
    require("conform").format {
        timeout_ms = 500,
        lsp_fallback = true,
    }
end, { desc = "LSP Formal buffer" })

-- DAP
map("n", "<leader>db", "<cmd>DapToggleBreakpoint<CR>", { desc = "DAP Toggle breakpoint" })
map("n", "<leader>dr", "<cmd>DapContinue<CR>", { desc = "DAP Start debug menu" })
map("n", "<leader>dpr", function()
    require("dap-python").test_method()
end, { desc = "DAP Start python debug menu" })

-- Trouble
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

-- AI
map({ "n", "v" }, "<leader>ca", "<cmd>CodeCompanionActions<CR>", { desc = "CodeCompanion Actions" })
map({ "n", "v" }, "<leader>cc", "<cmd>CodeCompanionChat<CR>", { desc = "CodeCompanion Chat" })
map({ "n", "v" }, "<leader>cp", "<cmd>CodeCompanion<CR>", { desc = "CodeCompanion" })
