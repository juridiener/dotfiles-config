# Zed Keybindings Quick Reference

Press `space ?` to open this file anytime.

---

## File Navigation (`space f`)

| Key | Action |
|-----|--------|
| `space f f` | Find files (fuzzy search) |
| `space f t` | Find text in project (live grep) |
| `space f r` | Recent files |
| `space f b` | Search in current buffer |
| `space /` | Project-wide search |

---

## File Tree (`space e`)

| Key | Action |
|-----|--------|
| `space e` | Toggle file tree |
| `ctrl-h` | Move focus to file tree (from editor) |
| `ctrl-l` | Move focus to editor (from file tree) |
| `j/k` | Navigate up/down in tree |
| `l` | Expand folder / Open file |
| `h` | Collapse folder |
| `a` | New file |
| `shift-a` | New directory |
| `d` | Delete |
| `r` | Rename |

---

## Git (`space g`)

| Key | Action |
|-----|--------|
| `space g g` | Open Git panel (stage/unstage/commit) |
| `space g d` | Toggle inline diff (hunk view) |
| `space g b` | Toggle git blame |
| `space g r` | Revert current hunk |
| `space g t` | Open terminal (for lazygit/git commands) |
| `] c` | Jump to next hunk |
| `[ c` | Jump to previous hunk |

**Git Panel workflow:**
- `j/k` - Navigate files
- `x` - Stage/unstage file or hunk
- `i` - Write commit message
- `Enter` - Commit

---

## Splits/Windows (`space s`)

| Key | Action |
|-----|--------|
| `space s v` / `space \|` | Vertical split (left/right) |
| `space s h` / `space -` | Horizontal split (top/bottom) |
| `ctrl-h/j/k/l` | Navigate between splits |
| `space q` | Close current split |

---

## Diagnostics & Errors

| Key | Action |
|-----|--------|
| `space x x` | Toggle diagnostics panel |
| `space x p` | Run TypeScript type check |
| `] d` | Next diagnostic (any) |
| `[ d` | Previous diagnostic (any) |
| `] e` | Next error |
| `[ e` | Previous error |
| `] w` | Next warning |
| `[ w` | Previous warning |

---

## LSP & Code Actions (`space c`)

| Key | Action |
|-----|--------|
| `space c a` | Code actions |
| `space r n` | Rename symbol |
| `g d` | Go to definition |
| `g r` | Go to references (use `g r r` in Zed) |
| `g i` | Go to implementation |
| `shift-k` | Hover documentation |

---

## Buffers/Tabs (`space b`)

| Key | Action |
|-----|--------|
| `space b d` | Close buffer |
| `shift-h` | Previous buffer |
| `shift-l` | Next buffer |
| `space w` | Save file |
| `space q` | Close pane |

---

## Vim Basics

| Key | Action |
|-----|--------|
| `jk` | Escape (from insert mode) |
| `zz` | Toggle fold |
| `/` | Search in current file |
| `escape` | Clear search highlights |

---

## Copilot

| Key | Action |
|-----|--------|
| `alt-a` | Accept suggestion (insert mode) |
| `alt-]` | Next suggestion |
| `alt-[` | Previous suggestion |

---

## Project Panel Navigation

| Key | Action |
|-----|--------|
| `ctrl-h` | Focus file tree |
| `ctrl-l` | Focus editor |
| `j/k` | Navigate |
| `space e` | Toggle file tree (works from anywhere) |

---

## Command Palette

| Key | Action |
|-----|--------|
| `cmd-shift-p` | Open command palette |
| `cmd-k` | Open command palette (alternative) |
| `cmd-,` | Open settings |

---

## Tips

- **Search with filters**: Use Include/Exclude in search panel (`space /`)
- **Git staging**: Use Git panel (`space g g`) for staging individual hunks
- **Terminal access**: `space g t` for lazygit or git commands
- **TypeScript checks**: `space x p` to run type checking in Docker containers
