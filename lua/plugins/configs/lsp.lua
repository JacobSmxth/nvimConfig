-- LSP configuration using Neovim 0.11+ native API

local caps_ok, cmp_caps = pcall(require, "cmp_nvim_lsp")
local capabilities = caps_ok and cmp_caps.default_capabilities() or vim.lsp.protocol.make_client_capabilities()

local function on_attach(_, bufnr)
  local map = function(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
  end

  map("n", "gd", vim.lsp.buf.definition, "LSP: Go to Definition")
  map("n", "gr", vim.lsp.buf.references, "LSP: References")
  map("n", "K", vim.lsp.buf.hover, "LSP: Hover")
  map("n", "<leader>rn", vim.lsp.buf.rename, "LSP: Rename")

  map("n", "<leader>ca", vim.lsp.buf.code_action, "LSP: Code Action")
end

-- Helper to setup LSP server
local function setup_lsp(name, opts)
  opts = opts or {}
  opts.capabilities = capabilities
  opts.on_attach = on_attach

  vim.lsp.config[name] = opts
  vim.lsp.enable(name)
end

-- Clangd (C/C++)
setup_lsp("clangd", {
  cmd = { "clangd" },
  filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
  root_markers = { ".clangd", ".clang-tidy", ".clang-format", "compile_commands.json", "compile_flags.txt", "configure.ac", ".git" },
})

-- Gopls (Go)
if vim.fn.executable("gopls") == 1 then
  setup_lsp("gopls", {
    cmd = { "gopls" },
    filetypes = { "go", "gomod", "gowork", "gotmpl" },
    root_markers = { "go.work", "go.mod", ".git" },
  })
end

-- Pyright (Python)
setup_lsp("pyright", {
  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  root_markers = { "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", "Pipfile", "pyrightconfig.json", ".git" },
})

-- TypeScript
setup_lsp("ts_ls", {
  cmd = { "typescript-language-server", "--stdio" },
  filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
  root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" },
})

-- Rust Analyzer
setup_lsp("rust_analyzer", {
  cmd = { "rust-analyzer" },
  filetypes = { "rust" },
  root_markers = { "Cargo.toml", "rust-project.json", ".git" },
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        allFeatures = true,
      },
      checkOnSave = {
        command = "clippy",
      },
    },
  },
})

-- HTML
setup_lsp("html", {
  cmd = { "vscode-html-language-server", "--stdio" },
  filetypes = { "html" },
  root_markers = { "package.json", ".git" },
})

-- CSS
setup_lsp("cssls", {
  cmd = { "vscode-css-language-server", "--stdio" },
  filetypes = { "css", "scss", "less" },
  root_markers = { "package.json", ".git" },
})

-- Emmet
setup_lsp("emmet_ls", {
  cmd = { "emmet-ls", "--stdio" },
  filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_markers = { "package.json", ".git" },
})
