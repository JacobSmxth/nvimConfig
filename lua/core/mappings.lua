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

map("n", "/", ":Telescope current_buffer_fuzzy_find<CR>", opts)

map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)

map("n", "<leader>ff", ":Telescope find_files<CR>", opts)
map("n", "<leader>fg", ":Telescope live_grep<CR>", opts)
map("n", "<leader>fb", ":Telescope buffers<CR>", opts)

map("n", "<leader><leader>", "<C-^>", opts)

map("i", "jj", "<Esc>", opts)

map("n", "<S-L>", ":bnext<CR>", opts)
map("n", "<S-H>", ":bprevious<CR>", opts)

map("n", "<Esc>", ":noh<CR>", opts)

map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

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
