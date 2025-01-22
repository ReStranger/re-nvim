require("mason-nvim-dap").setup {
    ensure_installed = {
        "python",
        "codelldb",
        "js",
    },
    automatic_setup = true,
}
