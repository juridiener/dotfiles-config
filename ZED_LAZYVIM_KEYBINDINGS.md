# Zed Configuration - LazyVim Style Keybindings

## ✅ Configuration Files Created

All files are in `~/.config/zed/`:
- ✅ `settings.json` - Complete settings matching your LazyVim options.lua
- ✅ `keymap.json` - LazyVim-style `<leader>` keybindings (NOT default Zed shortcuts)
- ✅ `tasks.json` - TypeScript type check tasks for your Docker monorepo

---

## 🎯 Important: Your Keybindings Work Like LazyVim!

**Default Zed shortcuts are DISABLED**. Instead, you use LazyVim-style `<leader>` bindings:

| LazyVim | Zed Keybinding | Action |
|---------|----------------|--------|
| `<leader>ff` | `space f f` | **Find files** (NOT cmd-p) |
| `<leader>ft` | `space f t` | **Find text in project** (NOT cmd-shift-f) |
| `<leader>sg` | `space s g` | **Search grep** (same as ft) |
| `<leader>fr` | `space f r` | **Recent files** |
| `<leader>fb` | `space f b` | **Search open buffers** |
| `<leader>/` | `space /` | **Search in current buffer** |
| `<leader>e` | `space e` | **Toggle file tree** |

---

## 📋 Complete Keybinding Reference

### File Navigation
- `space f f` - Find files (Telescope find_files)
- `space f t` - Find text in project (live grep)
- `space f r` - Recent projects (oldfiles equivalent)
- `space f b` - Search in open buffers
- `space /` - Search in current buffer

### File Tree
- `space e` - Toggle file explorer
- (In file tree):
  - `l` - Open file/folder
  - `h` - Collapse folder
  - `a` - New file
  - `A` - New directory
  - `d` - Delete
  - `r` - Rename

### LSP & Code
- `space c a` - Code actions
- `space r n` - Rename symbol
- `gd` - Go to definition (vim default)
- `gr` - Go to references (vim default)
- `shift-m` - Show diagnostics/hover

### Git
- `space g d` - Toggle diff view
- `space g g` - Open terminal (for lazygit)

### Diagnostics
- `space x x` - Toggle diagnostics panel
- `space x p` - Run TypeScript type check (tasks)
- `]d` - Next diagnostic
- `[d` - Previous diagnostic

### Buffers/Windows
- `space b d` - Close buffer
- `space w` - Save file
- `space q` - Close active item/buffer
- `shift-h` - Previous buffer
- `shift-l` - Next buffer
- `ctrl-h/j/k/l` - Navigate between panes

### Vim Mode
- `jk` - Escape to normal mode (insert mode)
- `zz` - Toggle fold
- `ESC` - Clear search highlights

### Copilot
- `alt-a` - Accept suggestion (insert mode)
- `alt-[` - Previous suggestion
- `alt-]` - Next suggestion

### Debugging (F-keys)
- `F5` - Start/Continue debugger
- `F9` - Toggle breakpoint
- `F10` - Step over
- `F11` - Step into
- `F12` - Step out

### Pane Resizing
- `alt-up/down/left/right` - Resize panes

---

## 🚀 Quick Start

1. **Open Zed** in your project:
   ```bash
   zed .
   ```

2. **Install Rose Pine theme**:
   - Press `cmd-shift-p`
   - Type "extensions: install"
   - Search "Rose Pine"
   - Install

3. **Restart Zed** for settings to take effect

4. **Test your keybindings**:
   - `space f f` - Should open file finder
   - `space e` - Should toggle file tree
   - `jk` (in insert mode) - Should escape to normal mode
   - `space f t` - Should open project search

---

## ⚙️ Tasks (TypeScript Type Checking)

Access with `space x p` or `cmd-shift-p` → "task::Spawn"

Available tasks:
- **TypeScript: Check All (Monorepo)** - Full type check
- **TypeScript: Check NestJS API** - API only
- **TypeScript: Check Next.js App** - Cliniqon app only
- **Docker: Attach Debugger** - Attach to Node.js debugger
- **NestJS: Restart API Container** - Restart API
- **Next.js: Restart App Container** - Restart Next.js

---

## 🎨 Theme Note

Your config is set to use "Rosé Pine" theme (matching your LazyVim base16-rose-pine).

If Rose Pine isn't installed yet:
1. `cmd-shift-p` → "extensions: install extensions"
2. Search "Rose Pine"
3. Install "Rosé Pine Theme"
4. Restart Zed

Alternatively, change theme in settings.json to any available theme.

---

## 🔧 Customization

All config files are in `~/.config/zed/`:
- Edit `settings.json` for editor settings
- Edit `keymap.json` for keybindings
- Edit `tasks.json` for custom tasks

---

## 📝 What's Different from Default Zed?

**Disabled default shortcuts**:
- ❌ `cmd-p` (use `space f f` instead)
- ❌ `cmd-shift-f` (use `space f t` instead)
- ❌ `cmd-f` (use `space /` instead)

**Kept useful defaults**:
- ✅ `cmd-shift-p` - Command palette
- ✅ `cmd-,` - Settings
- ✅ `cmd-w` - Close tab
- ✅ `cmd-s` - Save

---

## 🐛 Troubleshooting

### Keybindings not working?
1. Check vim mode is enabled (bottom right should show "Normal", "Insert", etc.)
2. Restart Zed after config changes
3. Check `dev: open key context view` to debug

### Theme not showing?
1. Install Rose Pine extension
2. Restart Zed
3. Check settings.json has correct theme name

### Tasks not appearing?
1. Open command palette (`cmd-shift-p`)
2. Type "task::Spawn"
3. Should show list of tasks from tasks.json

---

**Enjoy your LazyVim-style Zed setup! 🎉**
