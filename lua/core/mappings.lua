local map = vim.keymap.set
local opts = { noremap = true, silent = true }

map("n", "<Up>", "<Nop>", opts)
map("n", "<Down>", "<Nop>", opts)
map("n", "<Left>", "<Nop>", opts)
map("n", "<Right>", "<Nop>", opts)
map("i", "<Up>", "<Nop>", opts)
map("i", "<Down>", "<Nop>", opts)
map("i", "<Left>", "<Nop>", opts)
map("i", "<Right>", "<Nop>", opts)
map("v", "<Up>", "<Nop>", opts)
map("v", "<Down>", "<Nop>", opts)
map("v", "<Left>", "<Nop>", opts)
map("v", "<Right>", "<Nop>", opts)

map("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

map("n", "<leader>i", function()
  local view = vim.fn.winsaveview()
  vim.cmd("normal! gg=G")
  vim.fn.winrestview(view)
end, { noremap = true, silent = true, desc = "Fix indentation" })

map("n", "<leader>/", ":Telescope current_buffer_fuzzy_find<CR>", { noremap = true, silent = true, desc = "Fuzzy find in buffer" })

map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)

map("n", "<leader>ff", ":Telescope find_files<CR>", opts)
map("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
map("n", "<leader>fb", ":Telescope buffers<CR>", opts)
map("n", "<leader>fs", ":AutoSession search<CR>", { noremap = true, silent = true, desc = "Find sessions" })
map("n", "<leader>fm", function()
  local ok_pickers, pickers = pcall(require, "telescope.pickers")
  local ok_finders, finders = pcall(require, "telescope.finders")
  local ok_conf, conf = pcall(require, "telescope.config")
  local ok_actions, actions = pcall(require, "telescope.actions")
  local ok_action_state, action_state = pcall(require, "telescope.actions.state")

  if not (ok_pickers and ok_finders and ok_conf and ok_actions and ok_action_state) then
    vim.notify("Telescope not available", vim.log.levels.ERROR)
    return
  end

  local man_pages = {}
  local handle = io.popen("man -k . 2>/dev/null | awk '{print $1}' | sort -u")

  if not handle then
    vim.notify("Failed to get man pages", vim.log.levels.ERROR)
    return
  end

  for page in handle:lines() do
    table.insert(man_pages, page)
  end
  handle:close()

  if #man_pages == 0 then
    vim.notify("No man pages found", vim.log.levels.WARN)
    return
  end

  pickers.new({}, {
    prompt_title = "Man Pages",
    finder = finders.new_table({ results = man_pages }),
    sorter = conf.values.generic_sorter({}),
    attach_mappings = function(prompt_bufnr)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        vim.cmd("Man " .. selection[1])
      end)
      return true
    end,
  }):find()
end, { noremap = true, silent = true, desc = "Find man pages" })

map("n", "<leader><leader>", "<C-^>", opts)

map("i", "jj", "<Esc>", opts)

-- Terminal mode escape
map("t", "jj", "<C-\\><C-n>", opts)

map("n", "<S-L>", ":bnext<CR>", opts)
map("n", "<S-H>", ":bprevious<CR>", opts)

map("n", "<Esc>", ":noh<CR>", opts)

map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Window splits
map("n", "<leader>wv", ":vsplit<CR>", { noremap = true, silent = true, desc = "Vertical split" })
map("n", "<leader>ws", ":split<CR>", { noremap = true, silent = true, desc = "Horizontal split" })
map("n", "<leader>wq", ":close<CR>", { noremap = true, silent = true, desc = "Close window" })
map("n", "<leader>wo", ":only<CR>", { noremap = true, silent = true, desc = "Close other windows" })

map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Move lines up/down with Alt+j/k
map("n", "<A-j>", ":m .+1<CR>==", opts)
map("n", "<A-k>", ":m .-2<CR>==", opts)
map("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
map("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

map("n", "git", "vito<Esc>", { noremap = true, silent = true, desc = "Go inner tag" })
map("n", "gi\"", "vi\"o<Esc>", { noremap = true, silent = true, desc = "Go inner \"" })
map("n", "gi'", "vi'o<Esc>", { noremap = true, silent = true, desc = "Go inner '" })
map("n", "gi`", "vi`o<Esc>", { noremap = true, silent = true, desc = "Go inner `" })
map("n", "gi(", "vi(o<Esc>", { noremap = true, silent = true, desc = "Go inner (" })
map("n", "gi)", "vi)o<Esc>", { noremap = true, silent = true, desc = "Go inner )" })
map("n", "gib", "vibo<Esc>", { noremap = true, silent = true, desc = "Go inner ()" })
map("n", "gi{", "vi{o<Esc>", { noremap = true, silent = true, desc = "Go inner {" })
map("n", "gi}", "vi}o<Esc>", { noremap = true, silent = true, desc = "Go inner }" })
map("n", "giB", "viBo<Esc>", { noremap = true, silent = true, desc = "Go inner {}" })
map("n", "gi[", "vi[o<Esc>", { noremap = true, silent = true, desc = "Go inner [" })
map("n", "gi]", "vi]o<Esc>", { noremap = true, silent = true, desc = "Go inner ]" })
map("n", "gi<", "vi<o<Esc>", { noremap = true, silent = true, desc = "Go inner <" })
map("n", "gi>", "vi>o<Esc>", { noremap = true, silent = true, desc = "Go inner >" })

-- Diagnostic navigation (not LSP-specific, always available)
map("n", "[d", vim.diagnostic.goto_prev, { noremap = true, silent = true, desc = "Previous diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { noremap = true, silent = true, desc = "Next diagnostic" })

-- Reload config
map("n", "<leader>R", function()
  for name, _ in pairs(package.loaded) do
    if name:match("^core") or name:match("^plugins") then
      package.loaded[name] = nil
    end
  end
  dofile(vim.env.MYVIMRC)
  vim.notify("Config reloaded!", vim.log.levels.INFO)
end, { noremap = true, silent = true, desc = "Reload config" })
