local map = vim.keymap.set
local opts = { buffer = true, silent = true }

map("n", "<leader>cr", function()
  vim.cmd("w")
  vim.cmd("TermExec cmd='python3 -m http.server 8000'")
  vim.notify("Live server started at http://localhost:8000", vim.log.levels.INFO)
end, vim.tbl_extend("force", opts, { desc = "HTML: Start live server" }))

map("n", "<leader>cf", function()
  vim.cmd("w")
  require("conform").format({ bufnr = vim.api.nvim_get_current_buf() })
  vim.cmd("e")
end, vim.tbl_extend("force", opts, { desc = "HTML: Format" }))

map("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "HTML: Code action" }))
