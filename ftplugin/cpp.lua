-- ============================================================================
-- C++ FTPLUGIN - Language-specific settings and keybindings
-- ============================================================================

local map = vim.keymap.set
local opts = { buffer = true, silent = true }

-- <leader>cc - Compile current C++ file
map("n", "<leader>cc", function()
  vim.cmd("w") -- Save first
  vim.cmd("!g++ -Wall -Wextra -std=c++17 -o %:r %")
end, vim.tbl_extend("force", opts, { desc = "C++: Compile with g++" }))

-- <leader>cr - Compile and run current C++ file
map("n", "<leader>cr", function()
  vim.cmd("w") -- Save first
  local file = vim.fn.expand("%")
  local output = vim.fn.expand("%:r")
  vim.cmd(string.format("TermExec cmd='clear && g++ -Wall -Wextra -std=c++17 -o %s %s 2>&1 && ./%s'", output, file, output))
end, vim.tbl_extend("force", opts, { desc = "C++: Compile and run" }))

-- <leader>cd - Compile with debug symbols
map("n", "<leader>cd", function()
  vim.cmd("w") -- Save first
  vim.cmd("!g++ -Wall -Wextra -std=c++17 -g -o %:r %")
end, vim.tbl_extend("force", opts, { desc = "C++: Compile with debug symbols" }))

-- <leader>cx - Run compiled executable
map("n", "<leader>cx", function()
  local output = vim.fn.expand("%:r")
  vim.cmd(string.format("TermExec cmd='clear && ./%s'", output))
end, vim.tbl_extend("force", opts, { desc = "C++: Run compiled executable" }))

-- <leader>cm - Compile with Makefile (if exists)
map("n", "<leader>cm", function()
  local makefile_exists = vim.fn.filereadable("Makefile") == 1 or vim.fn.filereadable("makefile") == 1
  if makefile_exists then
    vim.cmd("TermExec cmd='clear && make'")
  else
    vim.notify("No Makefile found in current directory", vim.log.levels.WARN)
  end
end, vim.tbl_extend("force", opts, { desc = "C++: Build with make" }))

-- <leader>cM - Clean make build
map("n", "<leader>cM", function()
  local makefile_exists = vim.fn.filereadable("Makefile") == 1 or vim.fn.filereadable("makefile") == 1
  if makefile_exists then
    vim.cmd("TermExec cmd='clear && make clean'")
  else
    vim.notify("No Makefile found in current directory", vim.log.levels.WARN)
  end
end, vim.tbl_extend("force", opts, { desc = "C++: Clean make build" }))

-- <leader>cv - Run with valgrind
map("n", "<leader>cv", function()
  local output = vim.fn.expand("%:r")
  vim.cmd(string.format("TermExec cmd='clear && valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes ./%s'", output))
end, vim.tbl_extend("force", opts, { desc = "C++: Run with valgrind" }))

-- <leader>cg - Debug with GDB
map("n", "<leader>cg", function()
  local output = vim.fn.expand("%:r")
  vim.cmd(string.format("TermExec cmd='clear && gdb ./%s'", output))
end, vim.tbl_extend("force", opts, { desc = "C++: Debug with GDB" }))
