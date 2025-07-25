require("nvim-treesitter.configs").setup {
    ensure_installed = {
        "lua",
        "luadoc",
        "c",
        "cpp",
        "cmake",
        "qmljs",
        "blueprint",
        "rust",
        "ron",
        "python",
        "html",
        "css",
        "scss",
        "javascript",
        "typescript",
        "tsx",
        "nix",
        "bash",
        "make",
        "yaml",
        "toml",
        "hyprlang",

        "markdown",
        "markdown_inline",

        "git_rebase",
        "gitattributes",
        "gitcommit",
        "gitignore",
    },

    sync_install = false,

    auto_install = false,

    highlight = {
        enable = true,
    },
}
