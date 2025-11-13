-- ============================================================================
-- PYTHON FTPLUGIN - Language-specific settings and keybindings
-- ============================================================================

local map = vim.keymap.set
local opts = { buffer = true, silent = true }

-- <leader>cr - Run current Python file
map("n", "<leader>cr", function()
  vim.cmd("w") -- Save first
  local file = vim.fn.expand("%")
  vim.cmd(string.format("TermExec cmd='clear && python3 %s'", file))
end, vim.tbl_extend("force", opts, { desc = "Python: Run current file" }))

-- <leader>ci - Run in interactive mode
map("n", "<leader>ci", function()
  vim.cmd("w") -- Save first
  local file = vim.fn.expand("%")
  vim.cmd(string.format("TermExec cmd='clear && python3 -i %s'", file))
end, vim.tbl_extend("force", opts, { desc = "Python: Run in interactive mode" }))

-- <leader>cp - Open Python REPL
map("n", "<leader>cp", function()
  vim.cmd("TermExec cmd='clear && python3'")
end, vim.tbl_extend("force", opts, { desc = "Python: Open REPL" }))

-- <leader>ct - Run pytest on current file
map("n", "<leader>ct", function()
  vim.cmd("w") -- Save first
  local file = vim.fn.expand("%")
  vim.cmd(string.format("TermExec cmd='clear && pytest %s -v'", file))
end, vim.tbl_extend("force", opts, { desc = "Python: Run pytest on current file" }))

-- <leader>cT - Run all pytest tests
map("n", "<leader>cT", function()
  vim.cmd("w") -- Save first
  vim.cmd("TermExec cmd='clear && pytest -v'")
end, vim.tbl_extend("force", opts, { desc = "Python: Run all pytest tests" }))

-- <leader>cc - Run pytest with coverage
map("n", "<leader>cc", function()
  vim.cmd("w") -- Save first
  vim.cmd("TermExec cmd='clear && pytest --cov=. --cov-report=term-missing'")
end, vim.tbl_extend("force", opts, { desc = "Python: Run pytest with coverage" }))

-- <leader>cd - Run with debugger (pdb)
map("n", "<leader>cd", function()
  vim.cmd("w") -- Save first
  local file = vim.fn.expand("%")
  vim.cmd(string.format("TermExec cmd='clear && python3 -m pdb %s'", file))
end, vim.tbl_extend("force", opts, { desc = "Python: Run with debugger (pdb)" }))

-- <leader>cm - Run as module
map("n", "<leader>cm", function()
  vim.ui.input({ prompt = "Module name: " }, function(module)
    if module and module ~= "" then
      vim.cmd("w") -- Save first
      vim.cmd(string.format("TermExec cmd='clear && python3 -m %s'", module))
    end
  end)
end, vim.tbl_extend("force", opts, { desc = "Python: Run as module" }))

-- <leader>cv - Create virtual environment
map("n", "<leader>cv", function()
  vim.ui.input({ prompt = "Virtual env name: ", default = "venv" }, function(venv_name)
    if venv_name and venv_name ~= "" then
      vim.cmd(string.format("TermExec cmd='clear && python3 -m venv %s'", venv_name))
    end
  end)
end, vim.tbl_extend("force", opts, { desc = "Python: Create virtual environment" }))

-- <leader>ca - Activate virtual environment
map("n", "<leader>ca", function()
  vim.ui.input({ prompt = "Virtual env name: ", default = "venv" }, function(venv_name)
    if venv_name and venv_name ~= "" then
      vim.cmd(string.format("TermExec cmd='clear && source %s/bin/activate'", venv_name))
    end
  end)
end, vim.tbl_extend("force", opts, { desc = "Python: Activate virtual environment" }))

-- <leader>cI - Install requirements
map("n", "<leader>cI", function()
  local req_file = vim.fn.filereadable("requirements.txt") == 1 and "requirements.txt" or nil
  if req_file then
    vim.cmd("TermExec cmd='clear && pip install -r requirements.txt'")
  else
    vim.notify("No requirements.txt found in current directory", vim.log.levels.WARN)
  end
end, vim.tbl_extend("force", opts, { desc = "Python: Install requirements.txt" }))

-- <leader>cf - Format with ruff
map("n", "<leader>cf", function()
  vim.cmd("w") -- Save first
  local file = vim.fn.expand("%")
  vim.cmd(string.format("TermExec cmd='clear && ruff format %s'", file))
end, vim.tbl_extend("force", opts, { desc = "Python: Format with ruff" }))

-- <leader>cl - Lint with ruff
map("n", "<leader>cl", function()
  local file = vim.fn.expand("%")
  vim.cmd(string.format("TermExec cmd='clear && ruff check %s'", file))
end, vim.tbl_extend("force", opts, { desc = "Python: Lint with ruff" }))

-- <leader>cL - Lint with ruff and fix
map("n", "<leader>cL", function()
  vim.cmd("w") -- Save first
  local file = vim.fn.expand("%")
  vim.cmd(string.format("TermExec cmd='clear && ruff check --fix %s'", file))
end, vim.tbl_extend("force", opts, { desc = "Python: Lint with ruff and fix" }))

-- <leader>cs - Type check with mypy
map("n", "<leader>cs", function()
  local file = vim.fn.expand("%")
  vim.cmd(string.format("TermExec cmd='clear && mypy %s'", file))
end, vim.tbl_extend("force", opts, { desc = "Python: Type check with mypy" }))

-- <leader>cb - Format with black
map("n", "<leader>cb", function()
  vim.cmd("w") -- Save first
  local file = vim.fn.expand("%")
  vim.cmd(string.format("TermExec cmd='clear && black %s'", file))
end, vim.tbl_extend("force", opts, { desc = "Python: Format with black" }))
