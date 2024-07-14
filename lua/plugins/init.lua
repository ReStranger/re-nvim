local lazy = require "lazy"
return {
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require "configs.conform"
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "configs.null-ls"
        end,
      },
    },
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- lua stuff
        "lua-language-server", --x86_64 only. also install in you $PATH
        "stylua", --x86_64 only. also install in you $PATH
        -- web dev stuff
        "html-lsp",
        "css-lsp",
        "prettier",
        "typescript-language-server",
        -- c/cpp stuff
        "clangd", --x86_64 only. also install in you $PATH
        "clang-format",
        -- rust
        "rust-analyzer", --x86_64 only. also install in you $PATH
        -- python stuff
        "pyright",
        "black",
        "mypy",
        "ruff",
        "debugpy",
        -- bash stuff
        "bash-language-server",
        -- markdown stuff
        "marksman",
        -- nix
        "nil",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "scss",
        "javascript",
        "typescript",
        "tsx",
        "c",
        "cpp",
        "rust",
        "toml",
        "python",
        "bash",
        "dockerfile",
        "markdown",
        "markdown_inline",
        "hyprlang",
        "nix",
      },
    },
  },
  -- UX and fixes
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
    "stevearc/dressing.nvim",
    lazy = false,
    dependencies = {
      "luukvbaal/statuscol.nvim",
    },
  },
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    opts = function()
      local mouse_scrolled = false
      for _, scroll in ipairs { "Up", "Down" } do
        local key = "<ScrollWheel" .. scroll .. ">"
        vim.keymap.set({ "", "i" }, key, function()
          mouse_scrolled = true
          return key
        end, { expr = true })
      end

      local animate = require "mini.animate"
      return {
        cursor = {
          enable = false, -- if u use neovide or alacritty-smooth-cursor
          -- enable = true,
        },
        resize = {
          enable = false,
        },
        scroll = {
          timing = animate.gen_timing.linear { duration = 150, unit = "total" },
          subscroll = animate.gen_subscroll.equal {
            predicate = function(total_scroll)
              if mouse_scrolled then
                mouse_scrolled = false
                return false
              end
              return total_scroll > 1
            end,
          },
        },
      }
    end,
  },
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require "configs.better_escape"
    end,
  },
  {
    "luukvbaal/statuscol.nvim",
    lazy = false,
    config = function()
      require "configs.statuscol"
    end,
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    event = "BufReadPost",
    config = function()
      require "configs.ufo"
    end,
  },
  {
    "MeanderingProgrammer/markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    event = "BufReadPost",
    config = function()
      require("render-markdown").setup {}
    end,
  },
  { "3rd/image.nvim" },
  -- AI
  {
    "Exafunction/codeium.vim",
    event = "VeryLazy",
    config = function()
      -- Change '<C-g>' here to any keycode you like.
      vim.keymap.set("i", "<C-;>", function()
        return vim.fn["codeium#Accept"]()
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<c-<>", function()
        return vim.fn["codeium#CycleCompletions"](1)
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<c->>", function()
        return vim.fn["codeium#CycleCompletions"](-1)
      end, { expr = true, silent = true })
      vim.keymap.set("i", "<c-x>", function()
        return vim.fn["codeium#Clear"]()
      end, { expr = true, silent = true })
    end,
  },

  --formating plugin
  {
    "dundalek/parpar.nvim",
    dependencies = { "gpanders/nvim-parinfer", "julienvincent/nvim-paredit" },
    lazy = false,
  },
  {
    "windwp/nvim-ts-autotag",
    dependencies = { "luukvbaal/statuscol.nvim" },
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
      require("nvim-ts-autotag").setup {
        opts = {
          enable_close = true,
          enable_rename = true,
          enable_close_on_slash = false,
        },
      }
    end,
  },
  -- DEBUGGER
  {
    "mfussenegger/nvim-dap",
    -- config = function(_, opts)
    -- require "configs.dap"
    -- end,
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
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
    "theHamsta/nvim-dap-virtual-text",
    lazy = false,
    config = function(_, opts)
      require("nvim-dap-virtual-text").setup()
    end,
  },
  -- PYTHON SETUP
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
      "rcarriga/nvim-dap-ui",
    },
    config = function(_, opts)
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
    end,
  },

  -- RUST
  {
    "mrcjkb/rustaceanvim",
    ft = { "rust" },
    version = "^4",
    lazy = false,
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
  {
    "rust-lang/rust.vim",
    ft = "rust",
    init = function()
      vim.g.rustfmt_autosave = 1
    end,
  },
}
