local map = vim.keymap.set
local opts = { buffer = true, silent = true }

map("n", "<leader>cf", function()
  vim.cmd("w")
  require("conform").format({ bufnr = vim.api.nvim_get_current_buf() })
  vim.cmd("e")
end, vim.tbl_extend("force", opts, { desc = "CSS: Format" }))

map("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "CSS: Code action" }))
