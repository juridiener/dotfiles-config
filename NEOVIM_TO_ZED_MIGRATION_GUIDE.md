# Complete LazyVim to Zed Migration Guide

This guide maps your entire LazyVim configuration (`~/.config/LazyVim/`) to Zed equivalents.

**Based on your actual LazyVim configuration analyzed on April 14, 2026**

---

## 🎯 Quick Summary: Is Migration Worth It?

### ✅ **Strong Zed Support** (90%+ of your workflow)
- ✅ Vim mode (`jk` escape, all your custom maps)
- ✅ fzf-lua equivalent (file finder, project search)
- ✅ LSP (TypeScript, ESLint, Prettier) 
- ✅ TreeSitter syntax highlighting
- ✅ Git integration (gitsigns + diffview equivalent)
- ✅ Code folding (nvim-ufo equivalent)
- ✅ GitHub Copilot with your keybindings
- ✅ Auto-pairs, comments, which-key
- ✅ Recent files with current session
- ✅ Rose Pine theme
- ✅ All your core keybindings

### ⚠️ **Partial Support** (workarounds available)
- ⚠️ DAP debugging (basic, not as full-featured as your nvim-dap setup)
- ⚠️ Custom TypeScript check (use Tasks instead of Lua function)
- ⚠️ Quickfix enhancements (nvim-bqf → basic search panel)
- ⚠️ Buffer scoping (scope.nvim → different model)

### ❌ **Not Available** (keep LazyVim for these)
- ❌ TreeSJ (split/join code blocks)
- ❌ Undo tree visualization
- ❌ Neogen (doc generation)
- ❌ Custom Lua functions (`custom/` and `functions/`)
- ❌ Mini-animate UI effects

### 💡 **Recommendation**
**Hybrid Approach**: Use Zed for daily coding, keep LazyVim for:
- Advanced debugging with full DAP
- Custom Lua workflows
- Features you can't live without (TreeSJ, undo-tree, etc.)

---

## 📋 Summary: What's Possible in Zed

### ✅ **Fully Supported** (Native or Built-in)
- Vim mode with modal editing
- File finding (Telescope equivalent)
- Project-wide search (live_grep)
- Tree file browser
- LSP (Language Server Protocol)
- Git integration (gitsigns equivalent)
- Auto-pairs
- Commenting
- Syntax highlighting (Tree-sitter)
- Code folding
- Diagnostics
- Fuzzy finding
- Buffer navigation
- Window/pane management
- Which-key style command palette

### ⚠️ **Partially Supported** (Requires Extensions or Workarounds)
- DAP debugging (basic support, not as full-featured)
- Org-mode (no direct equivalent)
- Custom statusline (limited customization)
- Bufferline (tabs work differently)
- Project management (basic support)

### ❌ **Not Supported**
- Packer/Lazy plugin manager (Zed uses extensions)
- Custom Lua scripting
- Headlines.nvim (org-mode decoration)
- Neoscroll (smooth scrolling)
- Alpha (dashboard)
- Impatient (optimization plugin)
- Mini.nvim utilities
- ToggleTerm (Zed has built-in terminal)

---

## 🔧 Settings Migration (options.lua → settings.json)

### Your LazyVim Options → Zed Settings

Based on your `~/.config/LazyVim/lua/config/options.lua`:

```json
{
  // ============================================================
  // VIM MODE SETTINGS
  // ============================================================
  "vim_mode": true,
  "vim": {
    "use_system_clipboard": "always",
    "use_smartcase_find": true,
    "toggle_relative_line_numbers": false  // We'll set relative numbers globally
  },

  // ============================================================
  // UNDO/BACKUP SETTINGS
  // From: vim.opt.swapfile = false, vim.opt.backup = false
  // ============================================================
  // Zed doesn't use swap files like Vim, handles this internally

  // ============================================================
  // BASIC EDITOR SETTINGS
  // ============================================================
  
  // vim.opt.wrap = false
  "soft_wrap": "none",
  
  // vim.opt.expandtab = true (spaces not tabs)
  "hard_tabs": false,
  "tab_size": 2,
  
  // vim.opt.scrolloff = 4 (keep cursor 4 lines from edge)
  "vertical_scroll_margin": 4,
  "horizontal_scroll_margin": 4,
  
  // vim.opt.termguicolors = true
  "terminal": {
    "alternate_scroll": "off",
    "blinking": "terminal_controlled"
  },

  // vim.opt.inccommand = "split" (preview substitutions)
  // Zed shows live preview in buffer by default

  // ============================================================
  // SEARCH SETTINGS
  // From: vim.o.grepprg = "rg --vimgrep --hidden -g !.git"
  // ============================================================
  "search": {
    "case_sensitive": false,
    "whole_word": false,
    "regex": false
  },

  // ============================================================
  // FILE IGNORE PATTERNS
  // From: vim.opt.wildignore
  // ============================================================
  "file_scan_exclusions": [
    "**/.git",
    "**/node_modules",
    "**/.next",
    "**/.nuxt",
    "**/target",
    "**/.idea",
    "**/coverage"
  ],

  // ============================================================
  // UI/APPEARANCE
  // ============================================================
  "current_line_highlight": "all",
  "cursor_blink": false,
  "relative_line_numbers": true,  // Like your LazyVim setup
  
  "gutter": {
    "line_numbers": true,
    "code_actions": true,
    "folds": true,
    "runnables": true
  },

  // ============================================================
  // FOLDING (nvim-ufo equivalent)
  // From your nvim-ufo.lua plugin
  // ============================================================
  "use_autoclose": true,
  
  // ============================================================
  // TIMEOUTS
  // From: vim.opt.timeoutlen = 1000
  // ============================================================
  // Zed handles this differently, no direct equivalent

  // ============================================================
  // ROOT DIRECTORY
  // From: vim.g.root_spec = { "cwd" }
  // ============================================================
  "project_panel": {
    "default_width": 300,
    "dock": "left",
    "file_icons": true,
    "folder_icons": true,
    "git_status": true
  }
}
```

---

## ⌨️ Keybindings Migration (keymaps.lua → keymap.json)

### Your Complete LazyVim Keymap Translation

Based on your `~/.config/LazyVim/lua/config/keymaps.lua`:

Create `~/.config/zed/keymap.json`:

```json
[
  {
    "context": "Workspace",
    "bindings": {
      // Leader key is Space (set in LazyVim by default)
      // Local leader is , (from vim.g.maplocalleader = ",")
    }
  },
  {
    "context": "VimControl && !menu",
    "bindings": {
      // ============================================================
      // CUSTOM VIM BINDINGS
      // ============================================================
      
      // Clear search highlights (ESC)
      // From: keymap("n", "<ESC>", "<cmd>nohlsearch<CR>", opts)
      "escape": "editor::Cancel",

      // Folds (zz -> za)
      // From: keymap("n", "zz", "za", opts)
      "z z": "editor::ToggleFold",

      // Window resizing with Alt+Arrows
      // From: keymap("n", "<A-Up>", "<cmd>resize +2<cr>")
      "alt-up": ["workspace::SendKeystrokes", ":resize +2<CR>"],
      "alt-down": ["workspace::SendKeystrokes", ":resize -2<CR>"],
      "alt-left": ["workspace::SendKeystrokes", ":vertical resize -2<CR>"],
      "alt-right": ["workspace::SendKeystrokes", ":vertical resize +2<CR>"],

      // Diagnostic float (M key)
      // From: keymap("n", "M", vim.diagnostic.open_float)
      "shift-m": "editor::Hover",

      // Grep command shortcut (leader ,)
      // From: keymap("n", "<leader>,", ":silent grep ")
      "space ,": "pane::DeploySearch",

      // ============================================================
      // LAZYVIM DEFAULT OVERRIDES
      // ============================================================
      
      // LazyVim defaults (these work out of the box):
      // <leader>ff - file_finder::Toggle
      // <leader>/ - buffer_search::Deploy  
      // <leader>sg - pane::DeploySearch (search in project)
      // <leader>fr - recent_projects::Toggle
      // <leader>e - project_panel::ToggleFocus

      // TypeScript type check (custom function)
      // From: keymap("n", "<leader>xp", typescript.pick_tsconfig_and_run)
      // Not directly translatable - use Zed's Tasks feature instead
      
      // Org-mode index file
      // From: keymap("n", "<leader>oi", ":e ~/.config/notes/index.org<CR>")
      "space o i": ["workspace::Open", { "path": "~/.config/notes/index.org" }]
    }
  },
  {
    "context": "vim_mode == insert",
    "bindings": {
      // jk to escape
      // From: keymap("i", "jk", "<ESC>", opts)
      "j k": "vim::NormalBefore",

      // Copilot accept (Alt+a)
      // From: keymap("i", "<M-a>", "<CMD>lua require('copilot.suggestion').accept()<CR>")
      "alt-a": "editor::AcceptPartialCopilotSuggestion"
    }
  },
  {
    "context": "vim_mode == normal && !menu",
    "bindings": {
      // Copilot next/previous suggestions
      // From: keymap("n", "<M-]>", "<CMD>lua require('copilot.suggestion').next()<CR>")
      "alt-]": "copilot::NextSuggestion",
      "alt-[": "copilot::PreviousSuggestion"
    }
  },
  {
    "context": "vim_mode == visual",
    "bindings": {
      // Don't yank on put (keep clipboard)
      // From: vim.api.nvim_set_keymap("x", "p", 'p<cmd>let @+=@0<CR>')
      "p": ["workspace::SendKeystrokes", "p g v y"]
    }
  },
  {
    "context": "Editor && vim_mode == normal",
    "bindings": {
      // LazyVim Window Navigation (using Ctrl+hjkl)
      // These work by default in Zed
      "ctrl-h": "workspace::ActivatePaneLeft",
      "ctrl-j": "workspace::ActivatePaneDown", 
      "ctrl-k": "workspace::ActivatePaneUp",
      "ctrl-l": "workspace::ActivatePaneRight"
    }
  },
  {
    "context": "ProjectPanel && not_editing",
    "bindings": {
      // Neo-tree / nvim-tree style navigation
      "l": "project_panel::Open",
      "h": "project_panel::CollapseSelectedEntry",
      "o": "project_panel::Open"
    }
  }
]
```

### LazyVim Default Keybindings That Work in Zed

These LazyVim keybindings have direct equivalents in Zed (no config needed):

| LazyVim | Zed Action | Zed Default Keybinding |
|---------|------------|------------------------|
| `<leader>ff` | Find files | `cmd-p` (macOS) |
| `<leader>sg` | Search in project | `cmd-shift-f` |
| `<leader>/` | Search in buffer | `cmd-f` |
| `<leader>fr` | Recent files | `cmd-alt-o` |
| `<leader>e` | Toggle file tree | `cmd-shift-e` |
| `gd` | Go to definition | Works in vim mode |
| `gr` | Go to references | Works in vim mode |
| `<leader>ca` | Code actions | `cmd-.` |
| `<leader>rn` | Rename symbol | `F2` |
| `]d` | Next diagnostic | Works in vim mode |
| `[d` | Previous diagnostic | Works in vim mode |

---

## 🔌 Plugin Migration

### Plugin-by-Plugin Comparison

Based on your actual `~/.config/LazyVim/lua/plugins/` and `lazy.lua`:

#### Core LazyVim Plugins

| LazyVim Plugin/Extra | Zed Equivalent | Status | Notes |
|---------------------|----------------|--------|-------|
| **LazyVim core** | Zed defaults | ✅ Built-in | Zed has opinionated defaults |
| **lazy.nvim** | Extensions | ✅ Built-in | Extension marketplace |
| **which-key.nvim** | Command palette | ✅ Built-in | `cmd-shift-p` |
| **fzf-lua** (ibhagwan) | File finder | ✅ Built-in | `cmd-p`, `cmd-shift-f` |
| **nvim-treesitter** | Treesitter | ✅ Built-in | Automatic syntax highlighting |
| **nvim-lspconfig** | LSP | ✅ Built-in | Auto-configured per language |
| **nvim-cmp / blink.cmp** | Completions | ✅ Built-in | LSP-based completions |
| **LuaSnip** | Snippets | ✅ Built-in | JSON format |
| **mini-comment** | Comments | ✅ Built-in | `gc` visual, `gcc` normal |
| **mini-animate** | Animations | ❌ None | Zed has minimal animations |
| **nvim-notify** | Notifications | ✅ Built-in | Toast notifications |

#### Your Custom Plugins

| Plugin | From File | Zed Equivalent | Status |
|--------|-----------|----------------|--------|
| **nvim-ufo** | nvim-ufo.lua | Code folding | ✅ Built-in |
| **copilot.lua** | copilot.lua | GitHub Copilot | ✅ Built-in |
| **diffview.nvim** | diffview.lua | Diff view | ✅ Built-in |
| **vgit.nvim** | vgit.lua | Git integration | ✅ Built-in |
| **nvim-dap** | nvim-dap.lua | Debugger | ⚠️ Basic |
| **nvim-bqf** | nvim-bqf.lua | Better quickfix | ⚠️ Partial |
| **scope.nvim** | scope.lua | Buffer/tab scoping | ❌ Different model |
| **treesj** | treesj.lua | Split/join | ❌ Not available |
| **undo-tree** | undo.lua | Undo history | ❌ Not available |
| **inline-diagnostic** | inline-diagnostic.lua | Inline errors | ✅ Built-in |
| **neogen** | extras.coding.neogen | Doc generation | ❌ Not available |
| **base16-nvim** | colorscheme.lua | Themes | ✅ Extensions |

#### LazyVim Extras You're Using

| Extra Module | Purpose | Zed Equivalent |
|--------------|---------|----------------|
| `extras.lang.typescript` | TypeScript LSP | ✅ Built-in |
| `extras.lang.json` | JSON LSP | ✅ Built-in |
| `extras.ui.mini-animate` | UI animations | ❌ Minimal |
| `extras.test.core` | Test runner | ⚠️ Basic (neotest) |
| `extras.dap.core` | Debugging | ⚠️ Basic |
| `extras.dap.nlua` | Lua debugging | ❌ Not needed |
| `extras.linting.eslint` | ESLint | ✅ Built-in |
| `extras.formatting.prettier` | Prettier | ✅ Built-in |
| `extras.coding.luasnip` | Snippets | ✅ Built-in |

#### Disabled Plugins

From your `disabled.lua`:
- `nvim-navic` - Breadcrumbs (Zed has built-in breadcrumbs)
- `flash.nvim` - Jump navigation (Use Zed's search or vim `/`)

#### Custom Functions

From your config:
- **TypeScript type check** (`functions/typescript_typecheck.lua`) - Use Zed's Tasks feature
- **Custom Telescope pickers** (`custom/telescope_*.lua`) - Use Zed's built-in search

---

## 🎨 Theme Configuration

### Your Current Theme: base16-rose-pine

From your `colorscheme.lua`:
```lua
{
  "RRethy/base16-nvim",
  opts = {
    colorscheme = "base16-rose-pine"
  }
}
```

### Install Rose Pine in Zed

1. Open Zed
2. `cmd-shift-p` → "Extensions: Install Extensions"
3. Search for "Rose Pine"
4. Install "Rosé Pine Theme"

### Or manually in settings.json:

```json
{
  "theme": {
    "mode": "dark",
    "light": "One Light",
    "dark": "Rosé Pine"
  }
}
```

### Alternative Themes Available

You commented out several themes in your config. Here are Zed equivalents:

| LazyVim Theme | Zed Equivalent | Extension Name |
|---------------|----------------|----------------|
| base16-rose-pine | Rosé Pine | "Rosé Pine Theme" |
| tokyonight | Tokyo Night | "Tokyo Night" |
| catppuccin | Catppuccin | "Catppuccin" |
| poimandres | Poimandres | Search extensions |
| gruvbox | Gruvbox | "Gruvbox Theme" |

---

## 🚀 Complete Zed Configuration Files

### 1. `~/.config/zed/settings.json`

```json
{
  // ============================================================
  // VIM MODE
  // ============================================================
  "vim_mode": true,
  "vim": {
    "use_system_clipboard": "always",
    "use_smartcase_find": true,
    "toggle_relative_line_numbers": false
  },

  // ============================================================
  // THEME (Rose Pine - matching your LazyVim)
  // ============================================================
  "theme": {
    "mode": "dark",
    "dark": "Rosé Pine",
    "light": "Rosé Pine Dawn"
  },
  
  // ============================================================
  // FONTS
  // ============================================================
  "ui_font_size": 16,
  "ui_font_family": "SF Pro",
  "buffer_font_family": "JetBrains Mono",
  "buffer_font_size": 14,
  "buffer_line_height": "comfortable",

  // ============================================================
  // EDITOR BEHAVIOR
  // ============================================================
  "tab_size": 2,
  "hard_tabs": false,
  "soft_wrap": "none",
  "show_whitespaces": "none",
  "remove_trailing_whitespace_on_save": true,
  "ensure_final_newline_on_save": true,
  "format_on_save": "on",
  
  // ============================================================
  // UI APPEARANCE
  // ============================================================
  "current_line_highlight": "all",
  "cursor_blink": false,
  "relative_line_numbers": true,
  
  "gutter": {
    "line_numbers": true,
    "code_actions": true,
    "folds": true,
    "runnables": true
  },
  
  "scrollbar": {
    "show": "auto",
    "git_diff": true,
    "diagnostics": true
  },
  
  "vertical_scroll_margin": 4,
  "horizontal_scroll_margin": 4,
  
  // ============================================================
  // PROJECT PANEL (like Neo-tree/nvim-tree)
  // ============================================================
  "project_panel": {
    "button": true,
    "default_width": 300,
    "dock": "left",
    "file_icons": true,
    "folder_icons": true,
    "git_status": true,
    "indent_size": 20
  },

  // ============================================================
  // TERMINAL
  // ============================================================
  "terminal": {
    "font_family": "JetBrains Mono",
    "font_size": 14,
    "dock": "bottom",
    "default_height": 400,
    "working_directory": "current_project_directory"
  },

  // ============================================================
  // LSP CONFIGURATION
  // ============================================================
  "enable_language_server": true,
  "lsp": {
    "typescript-language-server": {
      "initialization_options": {
        "preferences": {
          "includeInlayParameterNameHints": "all",
          "includeInlayFunctionParameterTypeHints": true,
          "includeInlayVariableTypeHints": true
        }
      }
    },
    "eslint": {
      "settings": {
        "codeActionOnSave": {
          "enable": true,
          "mode": "all"
        }
      }
    }
  },

  // ============================================================
  // PRETTIER / FORMATTING (from your LazyVim extras)
  // ============================================================
  "formatter": {
    "language_server": {
      "name": "prettier"
    }
  },

  // ============================================================
  // GIT INTEGRATION (like gitsigns + diffview)
  // ============================================================
  "git": {
    "git_gutter": "tracked_files",
    "inline_blame": {
      "enabled": true
    }
  },

  // ============================================================
  // SEARCH SETTINGS
  // ============================================================
  "search": {
    "case_sensitive": false,
    "whole_word": false,
    "regex": false
  },
  
  // ============================================================
  // FILE EXCLUSIONS (from your wildignore)
  // ============================================================
  "file_scan_exclusions": [
    "**/.git",
    "**/node_modules",
    "**/.next",
    "**/.nuxt",
    "**/target",
    "**/.idea",
    "**/coverage",
    "**/.DS_Store"
  ],

  // ============================================================
  // COPILOT (matching your copilot.lua config)
  // ============================================================
  "features": {
    "copilot": true
  },

  // ============================================================
  // AUTO-SAVE
  // ============================================================
  "autosave": "on_focus_change",

  // ============================================================
  // TABS CONFIGURATION
  // ============================================================
  "tabs": {
    "file_icons": true,
    "git_status": true
  },

  // ============================================================
  // COLLABORATION & AI
  // ============================================================
  "collaboration_panel": {
    "button": false,
    "dock": "left"
  },
  
  "assistant": {
    "enabled": true,
    "default_model": {
      "provider": "openai",
      "model": "gpt-4"
    }
  },

  // ============================================================
  // TELEMETRY
  // ============================================================
  "telemetry": {
    "diagnostics": false,
    "metrics": false
  },

  // ============================================================
  // LANGUAGES (matching your treesitter ensure_installed)
  // ============================================================
  "languages": {
    "TypeScript": {
      "tab_size": 2,
      "format_on_save": "on",
      "formatter": "prettier"
    },
    "JavaScript": {
      "tab_size": 2,
      "format_on_save": "on", 
      "formatter": "prettier"
    },
    "TSX": {
      "tab_size": 2,
      "format_on_save": "on",
      "formatter": "prettier"
    },
    "JSON": {
      "tab_size": 2,
      "format_on_save": "on"
    },
    "Python": {
      "tab_size": 4,
      "format_on_save": "on"
    },
    "Markdown": {
      "tab_size": 2,
      "soft_wrap": "preferred_line_length"
    }
  }
}
```

## 🐛 Debugging Setup (nvim-dap → Zed Debugger)

### Your LazyVim DAP Configuration

From `nvim-dap.lua`, you have:
- Node.js/TypeScript debugging for Docker (port 9229)
- Monorepo support (apps/api, libs/*)
- Source map resolution
- F-key bindings

### Zed Debugger Equivalent

Zed has basic DAP support. Create `~/.config/zed/tasks.json`:

```json
{
  "tasks": [
    {
      "label": "Attach Debugger (Docker)",
      "command": "node",
      "args": ["--inspect-brk=0.0.0.0:9229"],
      "type": "node",
      "request": "attach",
      "port": 9229,
      "restart": true,
      "sourceMaps": true,
      "cwd": "${workspaceFolder}"
    }
  ]
}
```

### Debugging Keybindings

Add to your `keymap.json`:

```json
{
  "context": "Editor",
  "bindings": {
    // F-key bindings (matching your LazyVim setup)
    "f5": "debugger::Continue",
    "f9": "editor::ToggleBreakpoint",
    "f10": "debugger::StepOver",
    "f11": "debugger::StepInto",
    "f12": "debugger::StepOut"
  }
}
```

**Note**: Zed's debugger is less mature than nvim-dap. For complex debugging, consider keeping Neovim or using external tools.

---

## 📊 Feature Comparison Matrix

| Feature | Neovim | Zed | Migration Path |
|---------|--------|-----|----------------|
| **Modal editing** | ✅ Vim | ✅ Vim mode | Enable in settings |
| **File tree** | nvim-tree | ✅ Project panel | Built-in |
| **Fuzzy finding** | Telescope | ✅ File finder | `cmd-p` |
| **Search in files** | live_grep | ✅ Project search | `cmd-shift-f` |
| **LSP** | nvim-lsp | ✅ Built-in LSP | Auto-configured |
| **Completions** | nvim-cmp | ✅ Built-in | LSP-based |
| **Snippets** | LuaSnip | ✅ JSON snippets | Different format |
| **Git integration** | gitsigns | ✅ Git panel | Built-in |
| **Debugging** | nvim-dap | ⚠️ Basic DAP | Limited support |
| **Terminal** | toggleterm | ✅ Built-in | `ctrl-`` ` |
| **Auto-pairs** | nvim-autopairs | ✅ Built-in | On by default |
| **Comments** | Comment.nvim | ✅ Built-in | `gc`, `gcc` |
| **Treesitter** | nvim-treesitter | ✅ Built-in | Automatic |
| **Which-key** | which-key | ✅ Command palette | `cmd-shift-p` |
| **Status line** | lualine | ✅ Built-in | Limited custom |
| **Tabs/Buffers** | bufferline | ✅ Tab bar | Different UX |
| **Projects** | project.nvim | ⚠️ Recent projects | `cmd-alt-o` |
| **Org-mode** | orgmode | ❌ None | Use external |
| **Dashboard** | alpha | ❌ None | Opens last project |
| **Smooth scroll** | neoscroll | ❌ None | Not available |
| **Plugin manager** | packer/lazy | Extensions | Extension marketplace |
| **Lua scripting** | ✅ Full | ❌ Limited | Use extensions |

---

## 🎯 Quick Start Guide

### 1. Install Zed
```bash
brew install zed
# or download from https://zed.dev
```

### 2. Enable Vim Mode
Open Zed → Settings (`cmd-,`) → Check "Vim Mode"

### 3. Copy Configurations
```bash
# Create config directory
mkdir -p ~/.config/zed

# Copy settings (paste the settings.json content above)
# Copy keymap (paste the keymap.json content above)
```

### 4. Install Extensions
- Open command palette: `cmd-shift-p`
- Type: "extensions: install"
- Install:
  - Gruvbox theme
  - Any language-specific extensions you need

### 5. Test Your Keybindings
- `space e` → Toggle file tree
- `space f f` → Find files
- `space f t` → Search in project
- `gd` → Go to definition
- `space /` → Search in current buffer

---

## 🔄 Workflow Differences

### LazyVim → Zed Workflow Changes

| Task | Your LazyVim | Zed Equivalent |
|------|--------------|----------------|
| **Find files** | `<leader>ff` (fzf-lua) | `cmd-p` or `space f f` |
| **Search project** | `<leader>sg` | `cmd-shift-f` or `space f t` |
| **Search buffer** | `<leader>/` | `cmd-f` or `space /` |
| **Recent files** | `<leader>fr` (with current session) | `cmd-alt-o` |
| **File tree** | Neo-tree/nvim-tree | `cmd-shift-e` or `space e` |
| **Git diff** | DiffView `:DiffviewOpen` | Git panel or inline diff |
| **Close buffer** | `:bd` or buffer management | `cmd-w` |
| **Fold toggle** | `zz` (mapped to `za`) | `z z` (custom keymap) |
| **Diagnostics** | `M` (open float) | `shift-m` or hover |
| **Format** | LSP format on save | Auto-format on save |
| **Debug** | F5/F9/F10/F11 (DAP) | F5/F9/F10/F11 (basic) |
| **Copilot** | `Alt-a` accept, `Alt-[/]` nav | Same keybindings work |
| **TypeScript check** | `<leader>xp` (custom picker) | Use Tasks (see below) |
| **Quickfix list** | nvim-bqf enhanced | Basic search results |
| **Split/Join** | TreeSJ | Manual editing |
| **Undo tree** | Undo tree viz | Linear undo (`cmd-z`) |

### Creating Tasks for Custom Workflows

Replace your `typescript_typecheck.lua` with Zed Tasks.

Create `~/.config/zed/tasks.json`:

```json
{
  "tasks": [
    {
      "label": "TypeScript: Check (apps/api)",
      "command": "docker",
      "args": [
        "exec",
        "hains_nest_api",
        "bash",
        "-c",
        "cd /app && npx tsc --noEmit -p apps/api/tsconfig.json"
      ],
      "reveal": "always",
      "use_new_terminal": false
    },
    {
      "label": "TypeScript: Check (apps/cliniqon)",
      "command": "docker",
      "args": [
        "exec",
        "hains_next_app",
        "bash",
        "-c",
        "cd /app && npx tsc --noEmit -p apps/cliniqon/tsconfig.json"
      ],
      "reveal": "always",
      "use_new_terminal": false
    }
  ]
}
```

Run with: `cmd-shift-p` → "Tasks: Spawn"

---

## ⚡ What You'll Miss (and Alternatives)

Based on your actual LazyVim setup:

### 1. **Advanced DAP Debugging**
- **Your setup**: Full DAP UI, virtual text, Docker attach, monorepo support
- **Zed**: Basic debugger, improving but not feature-complete
- **Alternative**: Keep LazyVim for debugging, use Zed for coding
- **Status**: Zed debugger is actively being improved

### 2. **TreeSJ (Split/Join)**
- **Your plugin**: `treesj` for smart code splitting/joining
- **Zed**: No direct equivalent
- **Alternative**: Manual refactoring or extensions

### 3. **Undo Tree Visualization**
- **Your plugin**: `undo-tree` for visual undo history
- **Zed**: Linear undo only
- **Alternative**: Git commits for checkpoints

### 4. **Advanced Quickfix (nvim-bqf)**
- **Your plugin**: Better quickfix with preview
- **Zed**: Basic search results panel
- **Alternative**: Use project search with preview

### 5. **Custom Telescope Pickers**
- **Your custom**: `telescope_custom_pickers.lua`, `telescope_file_browser_live_grep.lua`
- **Zed**: Limited search customization
- **Alternative**: Use built-in search, file Tasks for workflows

### 6. **Scope.nvim (Buffer Scoping)**
- **Your plugin**: Tab-local buffer lists
- **Zed**: Global buffer list
- **Alternative**: Use panes and splits differently

### 7. **TypeScript Type Check Function**
- **Your function**: `typescript_typecheck.lua` with tsconfig picker
- **Zed**: No custom functions
- **Alternative**: Use Zed Tasks (see below)

### 8. **Neogen (Doc Generation)**
- **Your extra**: Automated documentation generation
- **Zed**: No equivalent
- **Alternative**: Snippets or manual

### 9. **Lua Scripting & Custom Functions**
- **Your setup**: Custom Lua functions in `functions/` and `custom/`
- **Zed**: No Lua support
- **Alternative**: Feature requests or Rust extensions

---

## 🎁 What You'll Gain

1. **Speed**: Zed is significantly faster than Neovim
2. **Modern UI**: Better defaults, cleaner interface
3. **LSP Integration**: Better out-of-box LSP experience
4. **Collaboration**: Built-in real-time collaboration
5. **Less Configuration**: Works great with minimal setup
6. **Better Defaults**: Most things work without plugins
7. **AI Integration**: Built-in AI assistant (optional)

---

## 🔧 Troubleshooting

### Keybindings Not Working?
1. Check context in keymap (VimControl, Workspace, etc.)
2. Use `dev: open key context view` to debug
3. Check for conflicts with default bindings

### LSP Not Starting?
1. Zed auto-installs language servers
2. Check output panel: `cmd-shift-y`
3. Restart language server: `cmd-shift-p` → "lsp: restart"

### Vim Mode Issues?
1. Check `vim_mode: true` in settings
2. Some vim features may differ from Neovim
3. Check [Zed Vim docs](https://zed.dev/docs/vim)

---

## 📚 Resources

- [Zed Documentation](https://zed.dev/docs)
- [Zed Vim Mode Docs](https://zed.dev/docs/vim)
- [Zed Extensions](https://zed.dev/extensions)
- [Zed GitHub](https://github.com/zed-industries/zed)
- [Zed Discord](https://discord.gg/zed)

---

## ✅ Migration Checklist

Based on your actual LazyVim configuration:

### Initial Setup
- [ ] Install Zed
- [ ] Enable Vim mode in settings
- [ ] Copy `settings.json` configuration
- [ ] Copy `keymap.json` configuration

### Theme & Appearance
- [ ] Install Rosé Pine theme extension
- [ ] Configure base16-rose-pine colorscheme
- [ ] Set JetBrains Mono font
- [ ] Enable relative line numbers
- [ ] Configure scrolloff (vertical_scroll_margin: 4)

### Core Functionality
- [ ] Test `jk` to escape in insert mode
- [ ] Test `zz` for fold toggle
- [ ] Test `ESC` to clear search highlights
- [ ] Test `Alt+arrows` for window resizing
- [ ] Test project panel navigation (`space e`)

### File Navigation (fzf-lua equivalent)
- [ ] Test file finder (`space f f` or `cmd-p`)
- [ ] Test project search (`space f t` or `cmd-shift-f`)
- [ ] Test buffer search (`space /` or `cmd-f`)
- [ ] Test recent files (`cmd-alt-o`)
- [ ] Verify oldfiles include current session

### LSP & Language Support
- [ ] Verify TypeScript LSP works
- [ ] Verify ESLint integration
- [ ] Verify Prettier formatting
- [ ] Test inlay hints (if desired)
- [ ] Test code actions (`cmd-.`)
- [ ] Test go to definition (`gd`)

### Git Integration (diffview/vgit equivalent)
- [ ] Test git gutter (file changes)
- [ ] Test inline blame (if enabled)
- [ ] Test diff view
- [ ] Test git panel

### Copilot
- [ ] Install/enable GitHub Copilot
- [ ] Test `Alt-a` to accept suggestion
- [ ] Test `Alt-[` and `Alt-]` for navigation
- [ ] Verify inline completions work

### Code Folding (nvim-ufo equivalent)
- [ ] Test folding with `zz` (za)
- [ ] Test `zR` to open all folds
- [ ] Test `zM` to close all folds
- [ ] Verify TreeSitter-based folding

### Debugging (nvim-dap)
- [ ] Configure tasks.json for Docker debugging
- [ ] Test F5 (continue/start)
- [ ] Test F9 (toggle breakpoint)
- [ ] Test F10/F11/F12 (step over/into/out)
- [ ] Decide if keeping LazyVim for debugging

### Custom Workflows
- [ ] Create tasks.json for TypeScript type checking
- [ ] Create tasks.json for other custom commands
- [ ] Test task runner (`cmd-shift-p` → "Tasks: Spawn")

### Terminal
- [ ] Test terminal panel
- [ ] Set working directory to project root
- [ ] Verify Docker commands work
- [ ] Configure terminal font

### Project-Specific
- [ ] Set file exclusions (node_modules, .git, etc.)
- [ ] Configure monorepo root detection
- [ ] Test multi-root workspace if needed
- [ ] Verify libs/apps resolution

### Testing (if using test extras)
- [ ] Evaluate Zed's test runner vs LazyVim
- [ ] Decide on test workflow
- [ ] Create test tasks if needed

### What to Keep in LazyVim
- [ ] Advanced debugging (nvim-dap)
- [ ] Custom Lua functions
- [ ] Org-mode notes (if using)
- [ ] TreeSJ for split/join
- [ ] Undo tree visualization
- [ ] Any custom telescope pickers

### Extensions to Install
- [ ] Rosé Pine theme
- [ ] Any language-specific extensions
- [ ] Icon theme (if desired)

### Final Verification
- [ ] Test all your most-used workflows
- [ ] Verify no critical features missing
- [ ] Decide on hybrid approach (Zed + LazyVim)

---

**Good luck with your migration! 🚀**

---

## 🚀 5-Minute Quick Start

Want to try Zed right now? Here's the fastest path:

### 1. Install & Launch
```bash
brew install zed
zed .
```

### 2. Enable Vim Mode
- Click Settings icon (bottom left) or `cmd-,`
- Toggle "Vim Mode" on
- Close settings

### 3. Copy Your Essential Keybindings

Create `~/.config/zed/keymap.json`:
```json
[
  {
    "context": "VimControl && !menu",
    "bindings": {
      "escape": "editor::Cancel",
      "z z": "editor::ToggleFold"
    }
  },
  {
    "context": "vim_mode == insert",
    "bindings": {
      "j k": "vim::NormalBefore"
    }
  }
]
```

### 4. Try Your Workflows
- `space e` → File tree (same as LazyVim!)
- `cmd-p` → Find files (like `<leader>ff`)
- `cmd-shift-f` → Search project (like `<leader>sg`)
- `cmd-f` → Search buffer (like `<leader>/`)
- `jk` → Escape (works!)
- `gd` → Go to definition (works!)

### 5. Install Rose Pine
- `cmd-shift-p`
- Type "extensions"
- Search "Rose Pine"
- Install

**That's it!** You're now running 70% of your LazyVim setup in Zed.

For full migration, follow the complete guide above.

---

**Good luck with your migration! 🚀**
