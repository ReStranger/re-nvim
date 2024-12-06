local g = vim.g
local map = vim.keymap.set
local bo = vim.bo
local lsp = vim.lsp
local api =  vim.api
local diagnostic = vim.diagnostic
local inspect = vim.inspect
g.mapleader = " "
g.maplocalleader = "\\"

-- Neotree
map("n", "<leader>i", "<cmd>Neotree float toggle<CR>")
map("n", "<C-n>", "<cmd>Neotree left toggle<CR>")

-- LSP
map("n", "<leader>lD", diagnostic.open_float)
map("n", "[d", diagnostic.goto_prev)
map("n", "]d", diagnostic.goto_next)
map("n", "<leader>ld", diagnostic.setloclist)

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
