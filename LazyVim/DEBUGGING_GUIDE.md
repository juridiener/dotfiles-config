# NeoVim Debugging Guide for NestJS

## 🎯 Quick Start

### 1. Start Debugging Session
```bash
# 1. Make sure Docker container is running
docker ps | grep nest

# 2. Open Neovim in your workspace
cd /Users/juri.diener/Documents/projects/hains/hains_docker/monorepo/my_workspace
nvim
```

### 2. Set Breakpoints and Debug
```
1. Open any TypeScript file (e.g., libs/prisma_cruds/src/lib/dienstwunsch.ts)
2. Navigate to the line where you want to break
3. Press <F9> to set a breakpoint
4. Press <F5> to start debugging
5. Select "Attach to NestJS API (Docker)"
6. Trigger the API call from your frontend
7. Watch the debugger stop at your breakpoint!
```

---

## ⌨️ Keybindings Reference

### F-Keys (Standard Debugging)
| Key | Action | Description |
|-----|--------|-------------|
| `<F5>` | Continue | Start debugging or continue execution |
| `<F9>` | Toggle Breakpoint | Set/remove breakpoint on current line |
| `<F10>` | Step Over | Execute current line, don't enter functions |
| `<F11>` | Step Into | Enter the function on current line |
| `<F12>` | Step Out | Exit current function |

### Leader Keys (Advanced Features)
| Key | Action | Description |
|-----|--------|-------------|
| `<leader>db` | Toggle DAP UI | Show/hide debug interface |
| `<leader>dr` | Toggle REPL | Open REPL to execute code |
| `<leader>dl` | Run Last | Repeat last debug configuration |
| `<leader>dB` | Conditional Breakpoint | Break only when condition is true |
| `<leader>dL` | Log Point | Log message instead of breaking |
| `<leader>dc` | Run to Cursor | Continue until cursor position |
| `<leader>dt` | Terminate | Stop debugging session |
| `<leader>dh` | Hover | Show variable value under cursor |
| `<leader>dp` | Preview | Preview variable value |

---

## 🎨 DAP UI Panels Explained

### Left Sidebar (50 columns)

#### 1. Scopes Panel (40%)
Shows all variables in current scope:
- **Local variables**: Variables in current function
- **Function arguments**: Parameters passed to function
- **Closure variables**: Variables from parent scopes

**Example:**
```
▾ Local
  ▸ dienstwunschId: 42
  ▸ user: { id: 42, name: "Max Mustermann" }
  ▸ data: { ... }
```

#### 2. Breakpoints Panel (20%)
Lists all breakpoints in project:
- File path and line number
- Condition (if conditional breakpoint)
- Enabled/disabled status

**Example:**
```
✓ apps/api/src/app/controller.ts:45
✓ libs/prisma_cruds/src/lib/dienstwunsch.ts:120 [id === 42]
✗ libs/models/src/lib/user.ts:30 (disabled)
```

#### 3. Stacks Panel (20%)
Shows call stack (function call hierarchy):
- Current function at top
- Calling functions below
- Click to navigate to function

**Example:**
```
▸ findDienstwunsch (dienstwunsch.ts:120)
▸ handleRequest (controller.ts:45)
▸ main (main.ts:30)
```

#### 4. Watches Panel (20%)
Custom expressions you want to monitor:
- Add with `:DapEval <expression>`
- Updates automatically as you step

**Example:**
```
▸ dienstwunschId: 42
▸ user.email: "max@example.com"
▸ data.length: 10
```

### Bottom Panel (10 lines)

#### 1. REPL (50%)
Execute code during debugging:
```javascript
> dienstwunschId
42
> dienstwunschId * 2
84
> user.name
"Max Mustermann"
```

#### 2. Console (50%)
Shows application console output:
```
[LOG] Starting bootstrap2:...
[INFO] ✅ PostgreSQL is ready!
[DEBUG] Processing dienstwunsch ID: 42
```

---

## 🔍 Conditional Breakpoints

### What are they?
Breakpoints that only trigger when a condition is true.

### When to use?
- Function called many times, but you only care about specific cases
- Debugging loops (break at iteration 500 of 1000)
- Debugging specific user/entity IDs

### How to use?

#### Method 1: Keybinding
```
1. Place cursor on line
2. Press <leader>dB
3. Enter condition: dienstwunschId === 42
4. Press Enter
```

#### Method 2: DAP UI
```
1. Set normal breakpoint with <F9>
2. Press <leader>db to open DAP UI
3. Navigate to Breakpoints panel
4. Edit breakpoint to add condition
```

### Example Conditions

**Specific ID:**
```javascript
dienstwunschId === 42
```

**Error cases only:**
```javascript
result.error !== null
```

**Large arrays:**
```javascript
items.length > 100
```

**String matching:**
```javascript
user.email.includes("@example.com")
```

**Complex conditions:**
```javascript
planId === 5 && userId === 123 && status === 'approved'
```

---

## 🔧 Testing Checklist

### Phase 1: Verify Setup
- [ ] Start Neovim: `nvim`
- [ ] Check for errors on startup (should be none)
- [ ] Verify Docker running: `docker ps | grep nest`
- [ ] Check port accessible: `nc -zv localhost 9229`

### Phase 2: Set Breakpoint
- [ ] Open file: `libs/prisma_cruds/src/lib/dienstwunsch.ts`
- [ ] Navigate to a function (e.g., line with `async findMany()`)
- [ ] Press `<F9>` to set breakpoint
- [ ] Verify breakpoint icon appears in gutter (should be red dot)

### Phase 3: Start Debugging
- [ ] Press `<F5>` to start debugging
- [ ] Select "Attach to NestJS API (Docker)" from picker
- [ ] Verify DAP UI opens automatically
- [ ] Check for success message: "✅ DAP Initialized!"

### Phase 4: Trigger Breakpoint
- [ ] From your Next.js frontend, click button that calls API
- [ ] Verify execution stops at breakpoint
- [ ] Check Scopes panel shows variables
- [ ] Verify inline virtual text shows variable values

### Phase 5: Debug Navigation
- [ ] Press `<F10>` to step over
- [ ] Press `<F11>` to step into a function
- [ ] Press `<F12>` to step out of function
- [ ] Check call stack in Stacks panel

### Phase 6: Advanced Features
- [ ] Press `<leader>dr` to open REPL
- [ ] Type variable name in REPL and press Enter
- [ ] Verify value is displayed
- [ ] Set conditional breakpoint: `<leader>dB`, enter `id === 42`
- [ ] Trigger multiple API calls, verify breakpoint only hits when condition true

### Phase 7: Cleanup
- [ ] Press `<F5>` to continue execution
- [ ] Verify DAP UI closes when debugging ends
- [ ] Press `<leader>db` to manually toggle UI

---

## 🚨 Troubleshooting

### Issue: "Cannot connect to debug adapter"

**Check Docker:**
```bash
docker ps | grep nest
# Should show: hains_nest_api with 0.0.0.0:9229->9229/tcp
```

**Check Port:**
```bash
nc -zv localhost 9229
# Should show: Connection to localhost port 9229 [tcp/*] succeeded!
```

**Check Process:**
```bash
docker exec hains_nest_api ps aux | grep inspect
# Should show: node --inspect=0.0.0.0:9229
```

**Check DAP Log:**
```bash
tail -f /tmp/dap.log
# Look for connection errors
```

**Solution:**
```bash
# Restart Docker container
docker-compose restart nestapi

# Or rebuild if needed
docker-compose up -d --build nestapi
```

---

### Issue: "Breakpoint not verified" (grey/hollow breakpoint)

**Possible Causes:**
1. Source maps not generated
2. File path doesn't match source map
3. Breakpoint set before attaching

**Check Source Maps:**
```bash
ls /Users/juri.diener/Documents/projects/hains/hains_docker/monorepo/my_workspace/dist/apps/api/*.js.map
# Should show .js.map files
```

**Check DAP Log:**
```bash
grep -i "source.*map" /tmp/dap.log
# Look for path resolution errors
```

**Solutions:**
1. Attach debugger first (`<F5>`), then set breakpoint (`<F9>`)
2. Verify webpack generates source maps (check webpack.hmr.config.js)
3. Try setting breakpoint in different file to test
4. Check if file path matches source map override patterns

---

### Issue: "Breakpoint hits but shows wrong file"

**Cause:** Source map path override patterns don't match

**Check DAP Log:**
```bash
grep -i "webpack" /tmp/dap.log | head -20
# Look at webpack:/// paths being generated
```

**Solution:** Update source map overrides in nvim-dap.lua

If you see paths like:
```
webpack:///../../apps/api/src/app/controller.ts
```

Add mapping:
```lua
["webpack:///../../apps/api/src/*"] = "${workspaceFolder}/apps/api/src/*",
```

---

### Issue: "Cannot see variable values"

**Check Virtual Text:**
```vim
:lua print(vim.inspect(require('nvim-dap-virtual-text')))
# Should show plugin is loaded
```

**Check Scopes Panel:**
- Open DAP UI with `<leader>db`
- Check Scopes panel on left
- Click arrows to expand variables

**Use REPL:**
- Press `<leader>dr` to open REPL
- Type variable name and press Enter
- Should show value

---

### Issue: "Debug session disconnects randomly"

**Possible Causes:**
1. Docker container restarted
2. Node process restarted (HMR)
3. Timeout in configuration

**Check Docker Logs:**
```bash
docker logs hains_nest_api --tail 50
# Look for restart messages
```

**Solution:**
- Set `restart = true` in DAP config (already done)
- Increase timeout in config (currently 60 seconds)
- Just restart debugging with `<F5>` after disconnect

---

## 📝 Debugging Workflow Example

### Scenario: Debug dienstwunsch creation in NestJS API

**1. Identify the code path:**
```
Frontend button click
  ↓
Next.js API route
  ↓
NestJS Controller (apps/api/src/app/dienstwuensche/controller.ts)
  ↓
NestJS Service (calls libs)
  ↓
Prisma CRUD (libs/prisma_cruds/src/lib/dienstwunsch.ts) ← YOU WANT TO DEBUG HERE
```

**2. Set breakpoints:**
```
1. Open: libs/prisma_cruds/src/lib/dienstwunsch.ts
2. Find: async create(data: DienstwunschCreateInput) { ... }
3. Press <F9> on first line inside function
4. Press <F9> on line that calls prisma.dienstwunsch.create()
```

**3. Start debugging:**
```
1. Press <F5>
2. Select "Attach to NestJS API (Docker)"
3. Wait for "✅ DAP Initialized!" message
```

**4. Trigger the code:**
```
1. Go to your Next.js frontend
2. Click "Create Dienstwunsch" button
3. Watch Neovim - execution should stop at first breakpoint
```

**5. Inspect data:**
```
1. Look at Scopes panel - see 'data' parameter
2. Expand 'data' to see all fields
3. Check virtual text inline for quick values
4. Press <leader>dr to open REPL
5. Type: data.mitarbeiterId
6. See the actual ID value
```

**6. Step through execution:**
```
1. Press <F10> to step to next line
2. Watch variable values update
3. Press <F11> to step into prisma.create() call
4. See Prisma's internal code (or skip with <F12>)
5. Press <F5> to continue to next breakpoint
```

**7. Check result:**
```
1. After prisma.create() returns
2. Check 'result' variable in Scopes
3. Verify ID was assigned
4. Verify all fields are correct
5. Press <F5> to let request complete
```

---

## 🎓 Advanced Tips

### Tip 1: Watch Expressions
Add custom watch expressions for complex values:
```vim
" In DAP UI Watches panel, press 'a' to add watch
" Enter: user.roles.map(r => r.name)
```

### Tip 2: Log Points
Debug without stopping execution:
```
1. Press <leader>dL on a line
2. Enter message: User ID is ${userId}
3. Check Console panel for output
4. No need to stop execution!
```

### Tip 3: REPL for Quick Tests
Test expressions without modifying code:
```javascript
> dienstwunschId * 2
84
> JSON.stringify(user)
{"id":42,"name":"Max"}
> Object.keys(data)
["id", "mitarbeiterId", "datum", "schichtId"]
```

### Tip 4: Multiple Breakpoints
Set breakpoints in multiple files to track data flow:
```
1. Breakpoint in controller.ts (entry point)
2. Breakpoint in service.ts (business logic)
3. Breakpoint in dienstwunsch.ts (data layer)
4. Press <F5> to jump between them
5. Watch data transform through layers
```

### Tip 5: Conditional in Loops
Debug specific iteration in a loop:
```typescript
for (let i = 0; i < 1000; i++) {
  processItem(i);  // <- Breakpoint here with condition: i === 500
}
```

Condition: `i === 500`

Only stops at iteration 500, not all 1000!

---

## 📚 Resources

**Check Configuration:**
- Config file: `~/.config/LazyVim/lua/plugins/nvim-dap.lua`
- Backup: `~/.config/LazyVim/lua/plugins/nvim-dap.lua.backup`

**Debug Logs:**
- DAP log: `/tmp/dap.log` (view with: `tail -f /tmp/dap.log`)
- Docker logs: `docker logs hains_nest_api`

**Project Paths:**
- Workspace: `/Users/juri.diener/Documents/projects/hains/hains_docker/monorepo/my_workspace`
- API: `apps/api/src/`
- Libs: `libs/prisma_cruds/`, `libs/models/`, etc.
- Dist: `dist/apps/api/`

**Helpful Commands:**
```bash
# Check Docker status
docker ps | grep nest

# Check debug port
nc -zv localhost 9229

# Restart NestJS container
docker-compose restart nestapi

# View DAP log live
tail -f /tmp/dap.log

# Find TypeScript files
find . -name "*.ts" -not -path "*/node_modules/*"
```

---

## 🎉 Happy Debugging!

You now have a full-featured debugging setup for your NestJS monorepo!

**Remember:**
- `<F9>` to set breakpoint
- `<F5>` to start/continue
- `<F10>/<F11>/<F12>` to navigate
- `<leader>db` to toggle UI
- `<leader>dB` for conditional breakpoints

**Need help?** Check:
1. This guide
2. `/tmp/dap.log`
3. Docker logs
4. Original config backup

Enjoy debugging your NestJS API! 🚀
