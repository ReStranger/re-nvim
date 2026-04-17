return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
        require("nvim-treesitter").install {
            "lua",
            "luadoc",
            "c",
            "cpp",
            "cmake",
            "qmljs",
            "bp",
            "dockerfile",
            "rust",
            "ron",
            "python",
            "regex",
            "html",
            "css",
            "scss",
            "javascript",
            "jsdoc",
            "typescript",
            "tsx",
            "nix",
            "bash",
            "make",
            "vim",
            "vimdoc",
            "xml",
            "yaml",
            "toml",
            "json",
            "hyprlang",

            "markdown",
            "markdown_inline",
            "latex",
            "diff",

            "git_config",
            "git_rebase",
            "gitattributes",
            "gitcommit",
            "gitignore",
        }
        vim.api.nvim_create_autocmd("FileType", {
            pattern = { "<filetype>" },
            callback = function()
                vim.treesitter.start()
            end,
        })
    end,
}
