-- Only run for cs files
if vim.bo.filetype ~= "cs" then
  return
end

local map = vim.keymap.set
local opts = { buffer = true, silent = true }

-- Helper to check for dotnet project
local function check_project()
  local has_project = vim.fn.glob("*.csproj") ~= ""
  if not has_project then
    vim.notify("Must be in a dotnet project to use this command", vim.log.levels.ERROR)
    return false
  end
  return true
end

-- Build
map("n", "<leader>cc", function()
  if not check_project() then return end
  vim.cmd("w")
  vim.cmd("TermExec cmd='clear && dotnet build'")
end, vim.tbl_extend("force", opts, { desc = "C#: Build" }))

-- Run
map("n", "<leader>cr", function()
  if not check_project() then return end
  vim.cmd("w")
  vim.cmd("TermExec cmd='clear && dotnet run'")
end, vim.tbl_extend("force", opts, { desc = "C#: Run" }))

-- Run (no build)
map("n", "<leader>cx", function()
  if not check_project() then return end
  vim.cmd("TermExec cmd='clear && dotnet run --no-build'")
end, vim.tbl_extend("force", opts, { desc = "C#: Run (no build)" }))

-- Clean
map("n", "<leader>cl", function()
  if not check_project() then return end
  vim.cmd("TermExec cmd='clear && dotnet clean'")
end, vim.tbl_extend("force", opts, { desc = "C#: Clean" }))

-- Format
map("n", "<leader>cf", function()
  vim.cmd("w")
  require("conform").format({ bufnr = vim.api.nvim_get_current_buf() })
  vim.cmd("e")
end, vim.tbl_extend("force", opts, { desc = "C#: Format" }))

-- Code action
map("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "C#: Code action" }))
