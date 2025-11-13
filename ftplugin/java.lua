-- ============================================================================
-- JAVA FTPLUGIN - Language-specific settings and keybindings
-- ============================================================================

-- Start jdtls for Gradle-backed Java projects (Spring Boot ready)
local ok, jdtls = pcall(require, "jdtls")
if not ok then
  vim.notify("nvim-jdtls not installed", vim.log.levels.ERROR)
  return
end

-- Prefer the module root (your app/ folder) so Gradle classpath is correct
local root_markers = { "gradlew", "build.gradle", "settings.gradle", ".git" }
local root_dir = require("jdtls.setup").find_root(root_markers)

-- If you often open from the repo root, force-resolve to app/ when needed
if root_dir and root_dir:match("/LedgerLite$") then
  local app_dir = root_dir .. "/app"
  if vim.fn.isdirectory(app_dir) == 1 then
    root_dir = app_dir
  end
end

if not root_dir or root_dir == "" then
  vim.notify("Java root not found. Open nvim in ~/dev/LedgerLite/app", vim.log.levels.WARN)
  return
end

-- Mason-installed jdtls shim
local jdtls_bin = vim.fn.expand("~/.local/share/nvim/mason/bin/jdtls")

-- Unique workspace per project
local workspace_dir = vim.fn.stdpath("data") .. "/jdtls-workspaces/" ..
                      vim.fn.fnamemodify(root_dir, ":p:h:t")

local config = {
  cmd = { jdtls_bin, "-data", workspace_dir },
  root_dir = root_dir,
  settings = {
    java = {
      configuration = {
        runtimes = {
          { name = "JavaSE-21", path = "/usr/lib/jvm/java-21-openjdk" },
          { name = "JavaSE-17", path = "/usr/lib/jvm/java-17-openjdk" },
        },
      },
      import = { gradle = { enabled = true } }, -- pull Gradle deps (Spring)
      eclipse = { downloadSources = true },
      maven = { downloadSources = true },
      signatureHelp = { enabled = true },
      contentProvider = { preferred = "fernflower" },
    },
  },
  init_options = { bundles = {} },
}

jdtls.start_or_attach(config)

-- ============================================================================
-- JAVA-SPECIFIC KEYBINDINGS
-- ============================================================================

local map = vim.keymap.set
local opts = { buffer = true, silent = true }

-- ============================================================================
-- LSP KEYBINDINGS (jdtls-specific, since we bypass lsp.lua)
-- ============================================================================

-- Wait for LSP to attach, then set up keybindings
vim.api.nvim_create_autocmd("LspAttach", {
  buffer = 0,
  callback = function(args)
    local bufnr = args.buf
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    -- Only set up for jdtls
    if client.name ~= "jdtls" then
      return
    end

    -- LSP keybindings
    map("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "LSP: Go to Definition" })
    map("n", "gr", vim.lsp.buf.references, { buffer = bufnr, desc = "LSP: References" })
    map("n", "K", vim.lsp.buf.hover, { buffer = bufnr, desc = "LSP: Hover" })
    map("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "LSP: Rename" })
    map("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "LSP: Code Action" })
    map("n", "<leader>oi", function()
      require("jdtls").organize_imports()
    end, { buffer = bufnr, desc = "Java: Organize Imports" })
  end,
})

-- ============================================================================
-- JAVA BUILD/RUN KEYBINDINGS
-- ============================================================================

-- Get the current class name from the file
local function get_class_name()
  local filename = vim.fn.expand("%:t:r") -- Get filename without extension
  return filename
end

-- Get main class for the project (searches for public static void main)
local function find_main_class()
  -- First, check if current file has main method
  local current_file = vim.fn.expand("%:p")
  local lines = vim.fn.readfile(current_file)
  for _, line in ipairs(lines) do
    if line:match("public%s+static%s+void%s+main") then
      return get_class_name()
    end
  end

  -- If not found, return nil (user needs to specify)
  return nil
end

-- <leader>cc - Compile current Java file
map("n", "<leader>cc", function()
  vim.cmd("w") -- Save first
  vim.cmd("!javac %")
end, vim.tbl_extend("force", opts, { desc = "Java: Compile current file" }))

-- <leader>cr - Compile and run current Java file
map("n", "<leader>cr", function()
  vim.cmd("w") -- Save first
  local file = vim.fn.expand("%")
  local class = vim.fn.expand("%:r")
  vim.cmd(string.format("TermExec cmd='clear && javac %s 2>&1 && java %s'", file, class))
end, vim.tbl_extend("force", opts, { desc = "Java: Compile and run" }))

-- <leader>cm - Run with manual class specification (for multi-file projects)
map("n", "<leader>cm", function()
  vim.ui.input({ prompt = "Main class name: ", default = get_class_name() }, function(main_class)
    if main_class and main_class ~= "" then
      vim.cmd("w") -- Save first
      local file = vim.fn.expand("%")
      vim.cmd(string.format("TermExec cmd='clear && javac %s 2>&1 && java %s'", file, main_class))
    end
  end)
end, vim.tbl_extend("force", opts, { desc = "Java: Compile and run (specify main class)" }))

-- <leader>cg - Run with Gradle (for Spring Boot projects)
map("n", "<leader>cg", function()
  if root_dir then
    vim.cmd(string.format("TermExec cmd='clear && cd %s && ./gradlew bootRun'", root_dir))
  else
    vim.notify("No Gradle project root found", vim.log.levels.ERROR)
  end
end, vim.tbl_extend("force", opts, { desc = "Java: Run with Gradle (bootRun)" }))

-- <leader>cb - Build with Gradle
map("n", "<leader>cb", function()
  if root_dir then
    vim.cmd(string.format("TermExec cmd='clear && cd %s && ./gradlew build'", root_dir))
  else
    vim.notify("No Gradle project root found", vim.log.levels.ERROR)
  end
end, vim.tbl_extend("force", opts, { desc = "Java: Build with Gradle" }))

-- <leader>ct - Run tests with Gradle
map("n", "<leader>ct", function()
  if root_dir then
    vim.cmd(string.format("TermExec cmd='clear && cd %s && ./gradlew test'", root_dir))
  else
    vim.notify("No Gradle project root found", vim.log.levels.ERROR)
  end
end, vim.tbl_extend("force", opts, { desc = "Java: Run tests with Gradle" }))
