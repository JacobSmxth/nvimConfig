-- ============================================================================
-- GO FTPLUGIN - Language-specific settings and keybindings
-- ============================================================================

local map = vim.keymap.set
local opts = { buffer = true, silent = true }

vim.opt_local.expandtab = false
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4

map("n", "<leader>cr", function()
  vim.cmd("w")
  local file = vim.fn.expand("%")
  vim.cmd(string.format("TermExec cmd='clear && go run %s'", file))
end, vim.tbl_extend("force", opts, { desc = "Go: Run" }))

map("n", "<leader>cb", function()
  vim.cmd("w")
  vim.cmd("TermExec cmd='clear && go build .'")
end, vim.tbl_extend("force", opts, { desc = "Go: Build" }))

map("n", "<leader>ct", function()
  vim.cmd("w")
  vim.cmd("TermExec cmd='clear && go test -v .'")
end, vim.tbl_extend("force", opts, { desc = "Go: Test" }))

map("n", "<leader>cf", function()
  vim.cmd("w")
  require("conform").format({ bufnr = vim.api.nvim_get_current_buf() })
  vim.cmd("e")
end, vim.tbl_extend("force", opts, { desc = "Go: Format" }))

map("n", "<leader>cm", function()
  vim.cmd("TermExec cmd='clear && go mod tidy'")
end, vim.tbl_extend("force", opts, { desc = "Go: mod tidy" }))

map("n", "<leader>ci", function()
  vim.lsp.buf.code_action({
    context = { only = { "source.organizeImports" } },
    apply = true,
  })
end, vim.tbl_extend("force", opts, { desc = "Go: Organize imports" }))

map("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Go: Code action" }))
