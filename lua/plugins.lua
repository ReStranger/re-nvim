---@diagnostic disable: undefined-global
local g = vim.g
---@diagnostic enable: undefined-global

local theme = {
    catppuccin = {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require "configs.catppuccin"
        end,
    },
    gruvbox = {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        opts = ...,
        config = function()
            require "configs.gruvbox"
        end,
    },
    touka = {
        "ReStranger/base16-nvim",
        branch = "blink-cmp-support",
        priority = 1000,
        config = function()
            require "configs.base16-themes.touka"
        end,
    },
    none = {},
}
local style = {
    normal = {
        "nvim-lualine/lualine.nvim",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            require "configs.lualine"
        end,
    },
    minimal = {},
}

require("lazy").setup {
    -- UI/UX
    {
        "nvim-neo-tree/neo-tree.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
            "s1n7ax/nvim-window-picker",
        },
        opts = require "configs.neo-tree",
    },
    {
        "akinsho/bufferline.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        opts = require "configs.bufferline",
    },
    style[g.re_nvim_style],
    g.re_nvim_statuscol == true and {
        "luukvbaal/statuscol.nvim",
        event = "VeryLazy",
        config = function()
            require "configs.statuscol"
        end,
    } or {},
    {
        "lukas-reineke/indent-blankline.nvim",
        event = { "BufReadPost", "BufNewFile" },
        main = "ibl",
        opts = {},
        config = function()
            require("ibl").setup { scope = { highlight = "@function" } }
        end,
    },
    {
        "brenoprata10/nvim-highlight-colors",
        event = "VeryLazy",
        config = function()
            require("nvim-highlight-colors").setup()
        end,
    },
    {
        "RRethy/vim-illuminate",
        event = "VeryLazy",
        config = function()
            require "configs.vim-illuminate"
        end,
    },
    {
        "kevinhwang91/nvim-ufo",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = "kevinhwang91/promise-async",
        opts = require "configs.ufo",
    },
    {
        "MysticalDevil/inlay-hints.nvim",
        event = "LspAttach",
        dependencies = { "neovim/nvim-lspconfig" },
        config = function()
            require("inlay-hints").setup()
        end,
    },
    g.re_nvim_noice == true and {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = "MunifTanjim/nui.nvim",
        opts = {},
    } or {},
    g.re_nvim_dashboard == true and {
        "nvimdev/dashboard-nvim",
        event = "VimEnter",
        dependencies = "nvim-tree/nvim-web-devicons",
        opts = require "configs.dashboard",
    } or {},
    {
        "xiyaowong/transparent.nvim",
        cmd = "TransparentToggle",
    },
    {
        "karb94/neoscroll.nvim",
        event = "VeryLazy",
        config = function()
            require("neoscroll").setup()
        end,
    },
    {
        "folke/todo-comments.nvim",
        event = "VeryLazy",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
            require("todo-comments").setup()
        end,
    },
    {
        "OXY2DEV/markview.nvim",
        ft = { "markdown", "markdown_inline", "codecompanion", "latex", "html" },
        config = function()
            require "configs.markview"
        end,
    },
    {
        "dundalek/parpar.nvim",
        event = "VeryLazy",
        dependencies = { "gpanders/nvim-parinfer", "julienvincent/nvim-paredit" },
    },
    {
        "christoomey/vim-tmux-navigator",
        cmd = {
            "TmuxNavigateLeft",
            "TmuxNavigateDown",
            "TmuxNavigateUp",
            "TmuxNavigateRight",
            "TmuxNavigatePrevious",
        },
    },
    {
        "nvim-telescope/telescope.nvim",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-ui-select.nvim",
        },
        config = function()
            require "configs.telescope"
        end,
    },
    {
        "akinsho/toggleterm.nvim",
        cmd = "ToggleTerm",
        version = "*",
        config = true,
    },
    {
        "folke/trouble.nvim",
        cmd = "Trouble",
    },
    {
        "NeogitOrg/neogit",
        cmd = "Neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",

            "nvim-telescope/telescope.nvim",
            "ibhagwan/fzf-lua",
            "echasnovski/mini.pick",
        },
    },
    {
        "olimorris/codecompanion.nvim",
        cmd = { "CodeCompanion", "CodeCompanionActions", "CodeCompanionChat", "CodeCompanionCmd" },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        opts = require "configs.codecompanion",
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        opts = require "configs.gitsigns",
    },
    theme[g.re_nvim_theme],
    -- Inline
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "VeryLazy" },
        build = ":TSUpdate",
        config = function()
            require "configs.nvim-treesitter"
        end,
    },
    {
        "neovim/nvim-lspconfig",
        event = "VeryLazy",
        dependencies = "williamboman/mason-lspconfig.nvim",
        config = function()
            require "configs.nvim-lspconfig"
        end,
    },
    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        dependencies = "zapling/mason-conform.nvim",
        config = function()
            require "configs.conform"
        end,
    },
    {
        "mfussenegger/nvim-lint",
        event = "VeryLazy",
        dependencies = "rshkarin/mason-nvim-lint",
        config = function()
            require "configs.lint"
        end,
    },
    {
        "rcarriga/nvim-dap-ui",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "mfussenegger/nvim-dap",
            event = { "BufReadPost", "BufNewFile" },
            config = function()
                require "configs.dap"
            end,
        },
        config = function()
            local dap = require "dap"
            local dapui = require "dapui"
            dapui.setup()
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end
        end,
    },
    {
        "jay-babu/mason-nvim-dap.nvim",
        event = "VeryLazy",
        dependencies = {
            "williamboman/mason.nvim",
            "mfussenegger/nvim-dap",
        },
        opts = require "configs.mason-dap-nvim",
    },
    {
        "mfussenegger/nvim-dap-python",
        ft = "python",
        dependencies = {
            "mfussenegger/nvim-dap",
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "jay-babu/mason-nvim-dap.nvim",
        },
        config = function(_, opts)
            local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
            require("dap-python").setup(path)
        end,
    },
    {
        "williamboman/mason.nvim",
        cmd = { "Mason" },
        opts = require "configs.mason",
    },
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            preset = "modern",
        },
        keys = {
            {
                "<leader>?",
                function()
                    require("which-key").show { global = false }
                end,
                desc = "Buffer Local Keymaps (which-key)",
            },
        },
    },
    -- Base function
    {
        "saghen/blink.cmp",
        dependencies = {
            "rafamadriz/friendly-snippets",
            "bydlw98/blink-cmp-env",
            "disrupted/blink-cmp-conventional-commits",
        },
        version = "1.*",
        event = "InsertEnter",
        opts = require "configs.blink-cmp",
        opts_extend = { "sources.default" },
    },
    {
        "max397574/better-escape.nvim",
        opts = require "configs.better-escape",
    },
    -- Rust
    {
        "mrcjkb/rustaceanvim",
        ft = { "rust" },
        version = "^6",
        config = function()
            require "configs.rustaceanvim"
        end,
    },
    {
        "saecki/crates.nvim",
        ft = { "toml" },
        config = function(_, opts)
            local crates = require "crates"
            crates.setup(opts)
            require("cmp").setup.buffer {
                sources = { { name = "crates" } },
            }
            crates.show()
        end,
    },
    -- Web
    {
        "windwp/nvim-ts-autotag",
        dependencies = "luukvbaal/statuscol.nvim",
        ft = {
            "astro",
            "glimmer",
            "handlebars",
            "html",
            "javascript",
            "jsx",
            "markdown",
            "php",
            "rescript",
            "svelte",
            "tsx",
            "twig",
            "typescript",
            "vue",
            "xml",
        },
        config = function()
            require("nvim-ts-autotag").setup {}
        end,
    },
    {
        "pmizio/typescript-tools.nvim",
        ft = {
            "astro",
            "glimmer",
            "handlebars",
            "html",
            "javascript",
            "jsx",
            "markdown",
            "php",
            "rescript",
            "svelte",
            "tsx",
            "twig",
            "typescript",
            "vue",
            "xml",
        },
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    },
    -- Apps
    {
        "eandrju/cellular-automaton.nvim",
        cmd = "CellularAutomaton",
    },
    {
        "andweeb/presence.nvim",
        event = "VeryLazy",
    },
    {
        "3rd/image.nvim",
        event = "VeryLazy",
        opts = require "configs.image",
    },
}
