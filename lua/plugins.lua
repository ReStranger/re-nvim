---@diagnostic disable: undefined-global
local g = vim.g
---@diagnostic enable: undefined-global

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
        config = function()
            require "configs.neo-tree"
        end,
    },
    {
        "akinsho/bufferline.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            require "configs.bufferline"
        end,
    },
    g.re_nvim_style ~= "minimal" and {
        "nvim-lualine/lualine.nvim",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = "nvim-tree/nvim-web-devicons",
        config = function()
            require "configs.lualine"
        end,
    } or {},
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
        ---@module "ibl"
        ---@type ibl.config
        opts = {},
        config = function()
            require("ibl").setup {}
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
        config = function()
            require "configs.ufo"
        end,
    },
    g.re_nvim_noice == true and {
        "folke/noice.nvim",
        event = "VeryLazy",
        opts = {},
        dependencies = "MunifTanjim/nui.nvim",
    } or {},
    g.re_nvim_dashboard == true and {
        "nvimdev/dashboard-nvim",
        event = "VimEnter",
        config = function()
            require "configs.dashboard"
        end,
        dependencies = "nvim-tree/nvim-web-devicons",
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
        "MeanderingProgrammer/markdown.nvim",
        ft = { "markdown", "markdown_inline" },
        dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
        config = function()
            require("render-markdown").setup {}
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
        opts = {},
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
        event = "VeryLazy",
        config = function()
            require "configs.codecompanion"
        end,
        opts = {},
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        config = function()
            require "configs.gitsigns"
        end,
    },
    g.re_nvim_theme == "catppuccin" and {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require "configs.catppuccin"
        end,
    } or {},

    g.re_nvim_theme == "gruvbox" and {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,
        config = true,
        opts = ...,
        config = function()
            require "configs.gruvbox"
        end,
    } or {},
    g.re_nvim_theme == "touka" and {
        "RRethy/base16-nvim",
        priority = 1000,
        config = function()
            require "configs.base16-themes.touka"
        end,
    } or {},
    -- Inline
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
        build = ":TSUpdate",
        config = function()
            require "configs.nvim-treesitter"
        end,
    },
    {
        "neovim/nvim-lspconfig",
        event = "User FilePost",
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
        config = function()
            require "configs.mason-dap-nvim"
        end,
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
        config = function()
            require "configs.mason"
        end,
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
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                dependencies = "rafamadriz/friendly-snippets",
                opts = { history = true, updateevents = "TextChanged,TextChangedI" },
                config = function(_, opts)
                    require("luasnip").config.set_config(opts)
                    require "configs.luasnip"
                end,
            },
            {
                "windwp/nvim-autopairs",
                opts = {
                    fast_wrap = {},
                    disable_filetype = { "TelescopePrompt", "vim" },
                },
                config = function(_, opts)
                    require("nvim-autopairs").setup(opts)

                    -- setup cmp for autopairs
                    local cmp_autopairs = require "nvim-autopairs.completion.cmp"
                    require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
                end,
            },
            {
                "saadparwaiz1/cmp_luasnip",
                "hrsh7th/cmp-nvim-lua",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
                "hrsh7th/cmp-cmdline",
                "petertriho/cmp-git",
            },
        },
        config = function()
            require "configs.nvim-cmp"
        end,
    },
    {
        "max397574/better-escape.nvim",
        config = function()
            require "configs.better-escape"
        end,
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
        event = "InsertEnter",
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
        event = "VeryLazy",
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
}
