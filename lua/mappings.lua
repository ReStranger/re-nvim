local g = vim.g
local map = vim.keymap.set
local bo = vim.bo
local lsp = vim.lsp
local api =  vim.api
local diagnostic = vim.diagnostic
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
		bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    local opts = { buffer = ev.buf }
    map('n', 'gD', lsp.buf.declaration, opts)
    map('n', 'gd', lsp.buf.definition, opts)
    map('n', 'K', lsp.buf.hover, opts)
    map('n', 'gi', lsp.buf.implementation, opts)
    map('n', '<C-k>', lsp.buf.signature_help, opts)

    -- vim.keymap.set('n', '<space>sa', vim.lsp.buf.add_workspace_folder, opts)
    -- vim.keymap.set('n', '<space>sr', vim.lsp.buf.remove_workspace_folder, opts)
    -- vim.keymap.set('n', '<space>sl', function()
    --   print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    -- end, opts)

    -- TODO: Используется повторно, необходимо вырезать в след.версии
    -- vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)

    map('n', '<leader>lr', lsp.buf.rename, opts)
    map({ 'n', 'v' }, '<leader>la', lsp.buf.code_action, opts)
    map('n', 'gr', lsp.buf.references, opts)
    map('n', '<leafer>lf', function()
      lsp.buf.format { async = true }
    end, opts)
  end,
})
