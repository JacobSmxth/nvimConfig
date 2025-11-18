# Ichthys.nvim

**Ichthys** (ikh-THOOS) - Greek for "fish", an ancient Christian symbol.

A modern, performance-focused Neovim configuration built to glorify the Lord through excellent software craftsmanship.

## Features

- **Modern Neovim 0.11+** native LSP with latest APIs
- **Lazy loading** for optimal startup performance
- **Full language support**: Java, Python, Go, Rust, C/C++, TypeScript/JavaScript, HTML/CSS
- **Complete debugging** setup with DAP
- **Git workflow** integration with LazyGit
- **Project sessions** with auto-save/restore
- **Custom VSCode Dark+** theme

---

## Keybindings

**Leader Key**: `Space`

### Navigation

| Keybind | Description |
|---------|-------------|
| `Shift+H` / `Shift+L` | Previous/Next buffer |
| `Ctrl+h/j/k/l` | Navigate windows |
| `<leader><leader>` | Toggle last two buffers |
| `-` | Open parent directory (Oil) |
| `<leader>-` | Open Oil (floating) |
| `<leader>e` | Toggle file tree |
| `<leader>a` | Toggle code outline |

### Search & Find (Telescope)

| Keybind | Description |
|---------|-------------|
| `/` | Native search (regex) |
| `<leader>/` | Fuzzy find in buffer |
| `<leader>ff` | Find files |
| `<leader>fg` | Live grep (search in files) |
| `<leader>fb` | Find buffers |
| `<leader>fs` | Find sessions |
| `<leader>fm` | Find man pages |

### Harpoon (Quick File Bookmarks)

| Keybind | Description |
|---------|-------------|
| `<leader>ha` | Add file |
| `<leader>hh` | Toggle menu |
| `<leader>h1-4` | Jump to file 1-4 |
| `<leader>hn` / `<leader>hp` | Next/Previous |

### LSP (Language Server)

| Keybind | Description |
|---------|-------------|
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gr` | Go to references |
| `gI` | Go to implementation |
| `gh` | Hover documentation |
| `K` | Man page lookup (native) |
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code action |
| `<leader>D` | Type definition |
| `[d` / `]d` | Previous/Next diagnostic |

### Git

| Keybind | Description |
|---------|-------------|
| `<leader>gg` | Open LazyGit |

### Editing

| Keybind | Description |
|---------|-------------|
| `jj` | Escape (insert/terminal mode) |
| `<leader>i` | Fix indentation (entire file) |
| `Alt+j` / `Alt+k` | Move line(s) up/down |
| `<` / `>` | Indent/outdent (stays in visual) |
| `gc` | Comment (motion/visual) |

### "Go Inner" (Custom Visual Selection)

Select inside and jump to end:

| Keybind | Selection |
|---------|-----------|
| `git` | Tag |
| `gi"` `gi'` `gi\`` | Quotes |
| `gi(` `gi)` `gib` | Parentheses |
| `gi{` `gi}` `giB` | Braces |
| `gi[` `gi]` | Brackets |
| `gi<` `gi>` | Angle brackets |

### Windows

| Keybind | Description |
|---------|-------------|
| `<leader>wv` | Vertical split |
| `<leader>ws` | Horizontal split |
| `<leader>wq` | Close window |
| `<leader>wo` | Close other windows |

### Hop (Motion)

| Keybind | Description |
|---------|-------------|
| `m` | Hop to word |
| `M` | Hop to line |

### REST Client (Kulala)

| Keybind | Description |
|---------|-------------|
| `<leader>kr` | Run request (.http files) |
| `<leader>kt` | Toggle headers/body |
| `<leader>kc` | Copy as cURL |

### Debugging (DAP)

| Keybind | Description |
|---------|-------------|
| `<leader>db` | Toggle breakpoint |
| `<leader>dc` | Continue |
| `<leader>di` | Step into |
| `<leader>do` | Step over |
| `<leader>dO` | Step out |
| `<leader>du` | Toggle debug UI |
| `<leader>dt` | Terminate |

### Diagnostics (Trouble)

| Keybind | Description |
|---------|-------------|
| `<leader>xx` | Toggle diagnostics |
| `<leader>xd` | Buffer diagnostics |
| `<leader>xq` | Quickfix list |

### Other

| Keybind | Description |
|---------|-------------|
| `<leader>u` | Undo tree |
| `<leader>R` | Reload config |
| `Ctrl+\` | Toggle terminal |
| `Esc` | Clear search highlight |

---

## Plugins

### UI & Navigation
- **dashboard-nvim** - Startup screen
- **nvim-tree.lua** - File explorer
- **oil.nvim** - Edit directories as buffers
- **telescope.nvim** - Fuzzy finder
- **harpoon** - Quick file bookmarks
- **aerial.nvim** - Code outline
- **lualine.nvim** - Statusline
- **which-key.nvim** - Keybind hints
- **indent-blankline.nvim** - Indent guides
- **nvim-web-devicons** - File icons

### LSP & Completion
- **mason.nvim** - LSP/tool installer
- **nvim-lspconfig** - LSP configurations
- **nvim-jdtls** - Java LSP
- **typescript-tools.nvim** - Enhanced TypeScript
- **nvim-cmp** - Completion engine
- **LuaSnip** - Snippets

### Code Intelligence
- **nvim-treesitter** - Syntax highlighting
- **nvim-treesitter-context** - Sticky scroll
- **nvim-ts-autotag** - Auto-close tags
- **conform.nvim** - Formatting

### Git
- **gitsigns.nvim** - Git signs in gutter
- **lazygit.nvim** - Full git workflow

### Editing
- **nvim-autopairs** - Auto-close brackets
- **Comment.nvim** - Easy commenting
- **nvim-surround** - Surround operations
- **hop.nvim** - Motion navigation

### Debugging
- **nvim-dap** - Debug Adapter Protocol
- **nvim-dap-ui** - Debug UI
- **nvim-dap-go** - Go debugging

### Utilities
- **auto-session** - Project session management
- **telescope-undo.nvim** - Visual undo tree
- **trouble.nvim** - Diagnostics list
- **toggleterm.nvim** - Terminal integration
- **kulala.nvim** - REST API client
- **render-markdown.nvim** - Markdown preview
- **todo-comments.nvim** - Highlight TODO/FIX/NOTE
- **fidget.nvim** - LSP progress UI
- **lorem.nvim** - Lorem ipsum generator

---

## Configuration Structure

```
~/.config/nvim/
├── init.lua                    # Entry point + VSCode Dark+ theme
├── lua/
│   ├── core/
│   │   ├── options.lua        # Vim options
│   │   ├── mappings.lua       # Keybindings
│   │   └── autocmds.lua       # Auto-commands
│   └── plugins/
│       ├── lazy_setup.lua     # Plugin definitions
│       └── configs/           # Plugin configurations
│           ├── lsp.lua
│           ├── telescope.lua
│           ├── cmp.lua
│           └── ...
└── ftplugin/                   # Filetype-specific configs
    ├── java.lua
    ├── python.lua
    ├── go.lua
    └── ...
```

---

## Custom Settings

### General
- **Line numbers**: Relative + absolute
- **Indentation**: 2 spaces (4 for Python/Go)
- **Clipboard**: System clipboard integrated
- **Persistent undo**: Enabled with 1000 levels
- **Mouse**: Enabled for scrolling only
- **No swap/backup files**

### Search
- Smart case-insensitive search
- Highlight search results
- `Esc` to clear highlights

### Splits
- Vertical splits open right
- Horizontal splits open below

### Performance
- Update time: 250ms
- Timeout: 300ms
- Lazy loading for all plugins

---

## Auto-Commands

- **Trim trailing whitespace** on save
- **Highlight yanked text** (200ms flash)
- **Auto-format Java** files on save
- **Restore cursor position** when reopening files
- **Disable auto-comment** on new lines
- **Smart indent settings** per filetype

---

## Language Support

### LSP Servers (Auto-installed via Mason)
- **Java**: jdtls
- **C/C++**: clangd
- **Python**: pyright
- **Go**: gopls
- **Rust**: rust-analyzer
- **TypeScript/JavaScript**: typescript-language-server
- **HTML**: html-lsp
- **CSS**: css-lsp
- **Emmet**: emmet-ls

### Formatters
- **Java**: google-java-format
- **Python**: black, isort
- **JavaScript/TypeScript**: prettier, eslint_d
- **Go**: gofumpt, goimports

### Debuggers
- **Go**: delve

---

## Session Management

Sessions auto-save on exit for git projects.

### Commands
- `:AutoSession save` - Manual save
- `:AutoSession delete` - Delete session
- `<leader>fs` - Find/restore sessions (Telescope)

Sessions are saved per git branch automatically.

---

## Performance

**Startup Time**: 57ms (measured with `time nvim +q`)

- Bare Neovim: 20-30ms
- This config: 57ms (50+ plugins, lazy loaded)
- Most configs: 100-300ms
- Heavy configs: 500ms+

### Benchmark Your Config

```bash
# Quick timing
time nvim +q

# Detailed startup log
nvim --startuptime startup.log +q && cat startup.log

# Plugin profiling (inside nvim)
:Lazy profile
```

---

## Requirements

- **Neovim** 0.11+
- **Git**
- **Ripgrep** (for telescope live_grep)
- **Make** (for telescope-fzf-native)
- **Node.js** (for some LSP servers)
- **LazyGit** (optional, for `<leader>gg`)
- **Nerd Font** (for icons)

---

## Installation

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.backup

# Clone this config
git clone https://github.com/JacobSmxth/Ichthys ~/.config/nvim

# Open nvim - plugins auto-install
nvim
```

---

## Philosophy

This configuration prioritizes:
1. **Performance** - Fast startup with lazy loading
2. **Simplicity** - Clean, organized structure
3. **Modern APIs** - Using Neovim 0.11+ native LSP
4. **Excellence** - Built to honor the Lord through quality work

"Commit thy works unto the Lord, and thy thoughts shall be established." - Proverbs 16:3 KJV

Production-ready professional development environment with excellent performance.
