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
            " ____       _____    ____   ____  _________________  ____   ____  _____      _____        ______  ",
            "|    |  ___|\\    \\  |    | |    |/                 \\|    | |    ||\\    \\    /    /|   ___|\\     \\ ",
            "|    | /    /\\    \\ |    | |    |\\______     ______|/    | |    || \\    \\  /    / |  |    |\\     \\",
            "|    ||    |  |    ||    |_|    |   \\( /    /  )/   |    |_|    ||  \\____\\/    /  /  |    |/____/|",
            "|    ||    |  |____||    .-.    |    ' |   |   '    |    .-.    | \\ |    /    /  /___|    \\|   | |",
            "|    ||    |   ____ |    | |    |      |   |        |    | |    |  \\|___/    /  /|    \\    \\___|/ ",
            "|    ||    |  |    ||    | |    |     /   //        |    | |    |      /    /  / |    |\\     \\    ",
            "|____||\\ ___\\/    /||____| |____|    /___//         |____| |____|     /____/  /  |\\ ___\\|_____|   ",
            "|    || |   /____/ ||    | |    |   |`   |          |    | |    |    |`    | /   | |    |     |   ",
            "|____| \\|___|    | /|____| |____|   |____|          |____| |____|    |_____|/     \\|____|_____|   ",
            "  \\(     \\( |____|/   \\(     )/       \\(              \\(     )/         )/           \\(    )/     ",
            "   '      '   )/       '     '         '               '     '          '             '    '      ",
            "              '                                                                                   ",
            "                               For the glory of God in all things                                 ",
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
          footer = { "Commit thy works unto the Lord, and thy thoughts shall be established. - Proverbs 16:3 KJV" },
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

  -- Undo tree with telescope
  {
    "debugloop/telescope-undo.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    keys = {
      { "<leader>u", "<cmd>Telescope undo<cr>", desc = "Undo tree" },
    },
    config = function()
      require("telescope").load_extension("undo")
    end,
  },

  -- Project session management
  {
    "rmagatti/auto-session",
    config = function()
      require("auto-session").setup({
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Downloads", "/" },
        auto_session_use_git_branch = true,
        session_lens = {
          prompt_title = "Sessions",
        },
      })

      vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

      local group = vim.api.nvim_create_augroup("AutoSessionMessages", { clear = true })
      vim.api.nvim_create_autocmd("User", {
        group = group,
        pattern = "AutoSessionRestored",
        callback = function()
          vim.defer_fn(function()
            vim.cmd("echon ''")
          end, 2000)
        end,
      })
    end,
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

  -- Oil.nvim (file explorer as a buffer)
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("oil").setup({
        default_file_explorer = false,
        columns = {
          "icon",
          "permissions",
          "size",
          "mtime",
        },
        buf_options = {
          buflisted = false,
          bufhidden = "hide",
        },
        win_options = {
          wrap = false,
          signcolumn = "no",
          cursorcolumn = false,
          foldcolumn = "0",
          spell = false,
          list = false,
          conceallevel = 3,
          concealcursor = "nvic",
        },
        delete_to_trash = false,
        skip_confirm_for_simple_edits = false,
        prompt_save_on_select_new_entry = true,
        cleanup_delay_ms = 2000,
        keymaps = {
          ["g?"] = "actions.show_help",
          ["<CR>"] = "actions.select",
          ["<C-v>"] = "actions.select_vsplit",
          ["<C-x>"] = "actions.select_split",
          ["<C-t>"] = "actions.select_tab",
          ["<C-p>"] = "actions.preview",
          ["<C-c>"] = "actions.close",
          ["<C-r>"] = "actions.refresh",
          ["-"] = "actions.parent",
          ["_"] = "actions.open_cwd",
          ["`"] = "actions.cd",
          ["~"] = "actions.tcd",
          ["gs"] = "actions.change_sort",
          ["gx"] = "actions.open_external",
          ["g."] = "actions.toggle_hidden",
          ["g\\"] = "actions.toggle_trash",
        },
        use_default_keymaps = true,
        view_options = {
          show_hidden = false,
          is_hidden_file = function(name, bufnr)
            return vim.startswith(name, ".")
          end,
          is_always_hidden = function(name, bufnr)
            return false
          end,
          sort = {
            { "type", "asc" },
            { "name", "asc" },
          },
        },
        float = {
          padding = 2,
          max_width = 90,
          max_height = 30,
          border = "rounded",
          win_options = {
            winblend = 0,
          },
        },
        preview = {
          max_width = 0.9,
          min_width = { 40, 0.4 },
          width = nil,
          max_height = 0.9,
          min_height = { 5, 0.1 },
          height = nil,
          border = "rounded",
          win_options = {
            winblend = 0,
          },
        },
        progress = {
          max_width = 0.9,
          min_width = { 40, 0.4 },
          width = nil,
          max_height = { 10, 0.9 },
          min_height = { 5, 0.1 },
          height = nil,
          border = "rounded",
          minimized_border = "none",
          win_options = {
            winblend = 0,
          },
        },
      })

      vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
      vim.keymap.set("n", "<leader>-", require("oil").toggle_float, { desc = "Open Oil (float)" })
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

  -- Lazygit integration
  {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Open LazyGit" },
    },
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

  -- Harpoon (quick file navigation)
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()

      vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon add file" })
      vim.keymap.set("n", "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon menu" })

      vim.keymap.set("n", "<leader>h1", function() harpoon:list():select(1) end, { desc = "Harpoon file 1" })
      vim.keymap.set("n", "<leader>h2", function() harpoon:list():select(2) end, { desc = "Harpoon file 2" })
      vim.keymap.set("n", "<leader>h3", function() harpoon:list():select(3) end, { desc = "Harpoon file 3" })
      vim.keymap.set("n", "<leader>h4", function() harpoon:list():select(4) end, { desc = "Harpoon file 4" })

      vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end, { desc = "Harpoon next" })
      vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end, { desc = "Harpoon prev" })
    end,
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

  -- Markdown preview
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    ft = "markdown",
    opts = {
      heading = {
        enabled = true,
        sign = true,
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      },
      code = {
        enabled = true,
        sign = true,
        style = "full",
        width = "block",
        left_pad = 2,
        right_pad = 2,
      },
      bullet = {
        enabled = true,
        icons = { "●", "○", "◆", "◇" },
      },
    },
  },

  -- REST client
  {
    "mistweaverco/kulala.nvim",
    ft = "http",
    keys = {
      { "<leader>kr", "<cmd>lua require('kulala').run()<cr>", desc = "Run request" },
      { "<leader>kt", "<cmd>lua require('kulala').toggle_view()<cr>", desc = "Toggle headers/body" },
      { "<leader>kc", "<cmd>lua require('kulala').copy()<cr>", desc = "Copy as cURL" },
    },
    config = function()
      require("kulala").setup()
    end,
  },

  -- Treesitter context (sticky scroll)
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      max_lines = 3,
    },
  },

  -- Code outline
  {
    "stevearc/aerial.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>a", "<cmd>AerialToggle<cr>", desc = "Toggle code outline" },
    },
    opts = {
      layout = {
        max_width = { 40, 0.2 },
        width = nil,
        min_width = 20,
      },
      attach_mode = "global",
      backends = { "lsp", "treesitter", "markdown", "man" },
      show_guides = true,
      filter_kind = false,
      guides = {
        mid_item = "├─",
        last_item = "└─",
        nested_top = "│ ",
        whitespace = "  ",
      },
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
        { "<leader>h", group = "Harpoon" },
        { "<leader>k", group = "Kulala (REST)" },
        { "<leader>l", group = "LSP" },
        { "<leader>x", group = "Trouble/Diagnostics" },
        { "<leader>w", group = "Window" },
        { "<leader>o", group = "Options/Other" },
        { "<leader>d", group = "Debug (DAP)" },
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
        { "<leader>fs", desc = "Find Sessions" },
        { "<leader>fh", desc = "Find Help" },
        { "<leader>fo", desc = "Find Old Files" },
        { "<leader>fc", desc = "Find Commands" },
        { "<leader>fk", desc = "Find Keymaps" },
        { "<leader>fm", desc = "Find Man Pages" },

        -- Buffer operations
        { "<leader>bd", desc = "Delete Buffer" },
        { "<leader>bn", desc = "Next Buffer" },
        { "<leader>bp", desc = "Previous Buffer" },


        -- Tree/Outline
        { "<leader>e", desc = "Toggle File Explorer" },
        { "<leader>a", desc = "Toggle Code Outline" },

        -- Other
        { "<leader>u", desc = "Undo Tree" },
        { "<leader>/", desc = "Fuzzy Find in Buffer" },
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
