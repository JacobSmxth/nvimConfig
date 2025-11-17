-- Plugin setup

require("lazy").setup({
  -- Dashboard
  {
    "nvimdev/dashboard-nvim",
    event = "VimEnter",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("dashboard").setup({
        theme = "doom",
        config = {
          header = {
            "",
            "",
            "   ▄████▄   ▒█████   ▓█████▄  ██▓ ███▄    █   ▄████",
            "  ▒██▀ ▀█  ▒██▒  ██▒ ▒██▀ ██▌▓██▒ ██ ▀█   █  ██▒ ▀█▒",
            "  ▒▓█    ▄ ▒██░  ██▒ ░██   █▌▒██▒▓██  ▀█ ██▒▒██░▄▄▄░",
            "  ▒▓▓▄ ▄██▒▒██   ██░ ░▓█▄   ▌░██░▓██▒  ▐▌██▒░▓█  ██▓",
            "  ▒ ▓███▀ ░░ ████▓▒░ ░▒████▓ ░██░▒██░   ▓██░░▒▓███▀▒",
            "  ░ ░▒ ▒  ░░ ▒░▒░▒░  ▒▒▓  ▒ ░▓  ░ ▒░   ▒ ▒   ░▒   ▒ ",
            "    ░  ▒     ░ ▒ ▒░  ░ ▒  ▒  ▒ ░░ ░░   ░ ▒░   ░   ░ ",
            "  ░        ░ ░ ░ ▒   ░ ░  ░  ▒ ░   ░   ░ ░  ░ ░   ░ ",
            "  ░ ░          ░ ░   ░  ░   ░     ░           ░   ",
            "   ░                        ░                      ",
            "              -- Coding for Christ --             ",
            "",
            "",
            "",
          },
          center = {
            { icon = " ", desc = "New File      ", key = "n", action = "ene | startinsert" },
            { icon = " ", desc = "Recent Files  ", key = "r", action = "Telescope oldfiles" },
            { icon = " ", desc = "Find File     ", key = "f", action = "Telescope find_files" },
            { icon = "󰍉 ", desc = "Grep Text     ", key = "g", action = "Telescope live_grep" },
            { icon = " ", desc = "Settings      ", key = "s", action = "edit $MYVIMRC" },
            { icon = " ", desc = "Quit Neovim   ", key = "q", action = "qa" },
          },
          footer = { "God is good. All the time." },
        },
      })

      vim.cmd([[
        highlight DashboardHeader guifg=#4fc1ff ctermfg=81
        highlight DashboardCenter guifg=#cccccc ctermfg=252
        highlight DashboardFooter guifg=#858585 gui=italic ctermfg=102 cterm=italic
        highlight DashboardKey guifg=#007acc gui=bold ctermfg=31 cterm=bold
        highlight DashboardIcon guifg=#c586c0 ctermfg=175
        highlight DashboardDesc guifg=#d4d4d4 ctermfg=188
      ]])
    end,
  },

  -- LSP Mason
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          border = "single",
          icons = {
            package_installed = "+",
            package_pending = "->",
            package_uninstalled = "x",
          },
        },
      })
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-tool-installer").setup({
        ensure_installed = {
          "jdtls",
          "clangd",
          "pyright",
          "typescript-language-server",
          "rust-analyzer",
          "google-java-format",
          "gopls",
          "delve",
          "gofumpt",
          "goimports",
          "html-lsp",
          "css-lsp",
          "emmet-ls",
          "prettier",
          "eslint_d",
        },
        auto_update = false,
        run_on_start = true,
      })
    end,
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("plugins.configs.lsp")
    end,
  },

  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
  },

  -- TypeScript enhanced support
  {
    "pmizio/typescript-tools.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
    ft = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    opts = {
      settings = {
        separate_diagnostic_server = true,
        publish_diagnostic_on = "insert_leave",
        tsserver_file_preferences = {
          includeInlayParameterNameHints = "all",
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayVariableTypeHints = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayEnumMemberValueHints = true,
        },
      },
    },
  },

  -- Formatting
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("conform").setup({
        formatters_by_ft = {
          java = { "google-java-format" },
          python = { "isort", "black" },
          javascript = { "prettier", "eslint_d" },
          typescript = { "prettier", "eslint_d" },
          javascriptreact = { "prettier", "eslint_d" },
          typescriptreact = { "prettier", "eslint_d" },
          json = { "prettier" },
          yaml = { "prettier" },
          markdown = { "prettier" },
          html = { "prettier" },
          css = { "prettier" },
          scss = { "prettier" },
          go = { "goimports", "gofumpt" },
        },
        formatters = {
          ["google-java-format"] = {
            command = vim.fn.stdpath("data") .. "/mason/bin/google-java-format",
          },
        },
      })
    end,
  },

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      require("plugins.configs.cmp")
    end,
  },

  {
    "hrsh7th/cmp-nvim-lsp",
  },

  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()

      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local f = ls.function_node

      local lorem_words = {
        "lorem", "ipsum", "dolor", "sit", "amet", "consectetur", "adipiscing", "elit",
        "sed", "do", "eiusmod", "tempor", "incididunt", "ut", "labore", "et", "dolore",
        "magna", "aliqua", "enim", "ad", "minim", "veniam", "quis", "nostrud",
        "exercitation", "ullamco", "laboris", "nisi", "aliquip", "ex", "ea", "commodo",
        "consequat", "duis", "aute", "irure", "in", "reprehenderit", "voluptate",
        "velit", "esse", "cillum", "fugiat", "nulla", "pariatur", "excepteur", "sint",
        "occaecat", "cupidatat", "non", "proident", "sunt", "culpa", "qui", "officia",
        "deserunt", "mollit", "anim", "id", "est", "laborum"
      }

      local function generate_lorem(count)
        local words = {}
        for i = 1, count do
          table.insert(words, lorem_words[(i - 1) % #lorem_words + 1])
        end
        return table.concat(words, " ")
      end

      ls.add_snippets("all", {
        s("lorem10", f(function() return generate_lorem(10) end)),
        s("lorem20", f(function() return generate_lorem(20) end)),
        s("lorem50", f(function() return generate_lorem(50) end)),
        s("lorem100", f(function() return generate_lorem(100) end)),
        s("lorem200", f(function() return generate_lorem(200) end)),
        s("lorem500", f(function() return generate_lorem(500) end)),
      })
    end,
  },

  {
    "rafamadriz/friendly-snippets",
    lazy = true,
  },

  {
    "saadparwaiz1/cmp_luasnip",
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("plugins.configs.treesitter")
    end,
  },

  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzf-native.nvim",
    },
    config = function()
      require("plugins.configs.telescope")
    end,
  },

  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },

  {
    "nvim-lua/plenary.nvim",
  },

  -- File explorer
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      require("plugins.configs.nvimtree")
    end,
  },

  -- Git signs
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("plugins.configs.gitsigns")
    end,
  },

  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("plugins.configs.autopairs")
    end,
  },

  -- Commenting
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("Comment").setup()
    end,
  },

  -- Hop motion (simpler alternative to flash)
  {
    "smoka7/hop.nvim",
    version = "*",
    keys = {
      { "m", "<cmd>HopWord<cr>", mode = { "n", "x", "o" }, desc = "Hop to word" },
      { "M", "<cmd>HopLine<cr>", mode = { "n", "x", "o" }, desc = "Hop to line" },
    },
    opts = {
      keys = "etovxqpdygfblzhckisuran",
      jump_on_sole_occurrence = true,
    },
  },

  -- Indent guides
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      indent = { char = "│" },
      scope = { enabled = false },
    },
  },

  -- Surround operations
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = true,
  },

  -- TODO comments highlighting
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },

  -- Auto close HTML/JSX tags
  {
    "windwp/nvim-ts-autotag",
    event = { "BufReadPost", "BufNewFile" },
    opts = {},
  },

  -- Lorem Ipsum generator
  {
    "derektata/lorem.nvim",
  },

  -- Treesitter context (sticky scroll)
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      max_lines = 3,
    },
  },

  -- LSP progress UI
  {
    "j-hui/fidget.nvim",
    opts = {},
  },

  -- Trouble diagnostics
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
      { "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics" },
      { "<leader>xq", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List" },
    },
  },

  -- Which-key
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.setup({
        preset = "modern",
        icons = {
          breadcrumb = ">",
          separator = "->",
          group = "+",
        },
        win = {
          border = "single",
          padding = { 1, 1 },
          wo = {
            winblend = 0,
          },
        },
        layout = {
          height = { min = 4, max = 15 },
          width = { min = 20, max = 50 },
          spacing = 3,
          align = "center",
        },
      })

      -- Register key group descriptions
      wk.add({
        -- Main leader groups
        { "<leader>f", group = "Find (Telescope)" },
        { "<leader>b", group = "Buffers" },
        { "<leader>g", group = "Git" },
        { "<leader>l", group = "LSP" },
        { "<leader>t", group = "Terminal/Toggle" },
        { "<leader>x", group = "Trouble/Diagnostics" },
        { "<leader>w", group = "Window" },
        { "<leader>o", group = "Options/Other" },
        { "<leader>d", group = "Debug (DAP)" },

        -- Filetype-adaptive code/compile group (changes based on current file)
        -- In C/C++: compile, run, debug, valgrind, make
        -- In Python: run, test, lint, format, venv
        -- In Java: compile, run, gradle, test
        { "<leader>c", group = "Code/Compile (filetype)" },

        -- Common LSP actions
        { "<leader>ca", desc = "Code Action" },
        { "<leader>rn", desc = "Rename Symbol" },

        -- Git operations
        { "<leader>gg", desc = "Open Lazygit" },
        { "<leader>gb", desc = "Git Blame" },
        { "<leader>gd", desc = "Git Diff" },
        { "<leader>gs", desc = "Git Status" },

        -- Find operations
        { "<leader>ff", desc = "Find Files" },
        { "<leader>fg", desc = "Find in Files (Grep)" },
        { "<leader>fb", desc = "Find Buffers" },
        { "<leader>fh", desc = "Find Help" },
        { "<leader>fo", desc = "Find Old Files" },
        { "<leader>fc", desc = "Find Commands" },
        { "<leader>fk", desc = "Find Keymaps" },
        { "<leader>fm", desc = "Find Marks" },

        -- Buffer operations
        { "<leader>bd", desc = "Delete Buffer" },
        { "<leader>bn", desc = "Next Buffer" },
        { "<leader>bp", desc = "Previous Buffer" },

        -- Terminal
        { "<leader>tt", desc = "Toggle Terminal" },
        { "<leader>tf", desc = "Toggle Float Terminal" },
        { "<leader>th", desc = "Toggle Horizontal Terminal" },
        { "<leader>tv", desc = "Toggle Vertical Terminal" },

        -- Tree
        { "<leader>e", desc = "Toggle File Explorer" },

        -- Other
        { "<leader>h", desc = "Clear Highlights" },
        { "<leader>oi", desc = "Organize Imports (Java)" },
      })
    end,
  },

  -- Terminal
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("plugins.configs.toggleterm")
    end,
  },

  -- DAP (Debug Adapter Protocol)
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",
      "leoluz/nvim-dap-go",
    },
    keys = {
      { "<leader>db", "<cmd>lua require('dap').toggle_breakpoint()<cr>", desc = "Toggle Breakpoint" },
      { "<leader>dc", "<cmd>lua require('dap').continue()<cr>", desc = "Continue" },
      { "<leader>di", "<cmd>lua require('dap').step_into()<cr>", desc = "Step Into" },
      { "<leader>do", "<cmd>lua require('dap').step_over()<cr>", desc = "Step Over" },
      { "<leader>dO", "<cmd>lua require('dap').step_out()<cr>", desc = "Step Out" },
      { "<leader>dr", "<cmd>lua require('dap').repl.toggle()<cr>", desc = "Toggle REPL" },
      { "<leader>dl", "<cmd>lua require('dap').run_last()<cr>", desc = "Run Last" },
      { "<leader>dt", "<cmd>lua require('dap').terminate()<cr>", desc = "Terminate" },
      { "<leader>du", "<cmd>lua require('dapui').toggle()<cr>", desc = "Toggle UI" },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()

      -- Auto open/close UI
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end

      require("nvim-dap-virtual-text").setup()
      require("dap-go").setup()
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
  },

  {
    "theHamsta/nvim-dap-virtual-text",
    dependencies = { "mfussenegger/nvim-dap" },
  },

  {
    "leoluz/nvim-dap-go",
    dependencies = { "mfussenegger/nvim-dap" },
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("plugins.configs.lualine")
    end,
  },

  -- Dev icons
  {
    "nvim-tree/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({
        override = {},
        default = true,
      })
    end,
  },
}, {
  -- Lazy config
  ui = {
    border = "single",
    icons = {
      cmd = "[CMD]",
      config = "[CFG]",
      event = "[EVT]",
      ft = "[FT]",
      init = "[INIT]",
      keys = "[KEY]",
      plugin = "[PLG]",
      runtime = "[RUN]",
      require = "[REQ]",
      source = "[SRC]",
      start = "[START]",
      task = "[TASK]",
      lazy = "[LAZY]",
    },
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
