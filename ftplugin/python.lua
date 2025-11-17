local map = vim.keymap.set
local opts = { buffer = true, silent = true }

map("n", "<leader>cr", function()
  vim.cmd("w")
  local file = vim.fn.expand("%")
  vim.cmd(string.format("TermExec cmd='clear && python3 %s'", file))
end, vim.tbl_extend("force", opts, { desc = "Python: Run" }))

map("n", "<leader>ct", function()
  vim.cmd("w")
  local file = vim.fn.expand("%")
  vim.cmd(string.format("TermExec cmd='clear && pytest %s -v'", file))
end, vim.tbl_extend("force", opts, { desc = "Python: Test file" }))

map("n", "<leader>cf", function()
  vim.cmd("w")
  require("conform").format({ bufnr = vim.api.nvim_get_current_buf() })
  vim.cmd("e")
end, vim.tbl_extend("force", opts, { desc = "Python: Format" }))

map("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Python: Code action" }))
