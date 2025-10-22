-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true, noremap = true }

keymap("i", "jk", "<ESC>", opts)
keymap("n", "<ESC>", "<cmd>nohlsearch<CR>", opts)

-- Folds
keymap("n", "zz", "za", opts)

-- Open Diffview mode
-- :window diffthis And close :window diffoff
-- keymap("n", "", rhs, opts)

-- remap ciw | Ciw to blackhole register
-- so that ciw does not override yank
-- keymap("n", "c", '"_c', opts)
-- keymap("n", "C", '"_C', opts)

-- Resize window using <alt> arrow keys
keymap("n", "<A-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
keymap("n", "<A-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
keymap("n", "<A-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
keymap("n", "<A-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

--
keymap("n", "M", vim.diagnostic.open_float)
keymap("n", "<leader>,", ":silent grep ", { silent = false })

-- Don't yank on put
vim.api.nvim_set_keymap("x", "p", 'p<cmd>let @+=@0<CR><cmd>let @"=@0<CR>', opts)

-- Set here because in copilot.lua the maps dont't work anymore
-- -- Accept suggestion
keymap("i", "<M-a>", "<CMD>lua require('copilot.suggestion').accept()<CR>", opts)
-- Next suggestion
keymap("n", "<M-]>", "<CMD>lua require('copilot.suggestion').next()<CR>", opts)
-- Previous suggestion
keymap("n", "<M-[>", "<CMD>lua require('copilot.suggestion').prev()<CR>", opts)

local function run_tsc_build(tsconfig_path)
  local buf = vim.api.nvim_create_buf(false, true)
  vim.bo[buf].buftype = "nofile"
  vim.bo[buf].bufhidden = "wipe"
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, { "⏳ Running TypeScript check..." })

  vim.cmd("botright 1split")
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(win, buf)
  vim.api.nvim_win_set_height(win, 1)
  vim.bo[buf].modifiable = false

  local output = {}

  vim.fn.jobstart({ "npx", "tsc", "-b", tsconfig_path, "--noEmit" }, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = function(_, data)
      if data then
        vim.list_extend(output, data)
      end
    end,
    on_stderr = function(_, data)
      if data then
        vim.list_extend(output, data)
      end
    end,
    on_exit = function(_, code)
      if vim.api.nvim_win_is_valid(win) then
        vim.api.nvim_win_close(win, true)
      end

      local items = {}
      for _, line in ipairs(output) do
        local filename, lnum, col, message = line:match("^(.-)%((%d+),(%d+)%):%s*(.+)$")
        if filename and lnum then
          filename = vim.trim(filename)
          local absolute_path = vim.fn.fnamemodify(filename, ":p")
          table.insert(items, {
            filename = absolute_path,
            lnum = tonumber(lnum),
            col = tonumber(col),
            text = message,
          })
        end
      end

      vim.fn.setqflist({}, " ", { title = "TypeScript Check", items = items })

      if code == 0 then
        vim.notify("TypeScript check passed!", vim.log.levels.INFO)
      else
        vim.schedule(function()
          vim.cmd("Trouble quickfix")
          vim.keymap.set("n", "q", "<cmd>Trouble quickfix close<cr>", { buffer = true, silent = true })
        end)
      end
    end,
  })
end

-- Your existing picker function calls run_tsc_build as before

local function pick_tsconfig_and_run()
  local all_tsconfigs = {}
  -- Use fd asynchronously to find tsconfig.json files quickly
  vim.fn.jobstart({ "fd", "--type", "f", "tsconfig.json", "--exclude", "node_modules" }, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      if data then
        for _, line in ipairs(data) do
          if line ~= "" then
            table.insert(all_tsconfigs, line)
          end
        end
      end
    end,
    on_exit = function()
      if #all_tsconfigs == 0 then
        vim.schedule(function()
          vim.notify("No tsconfig.json files found.", vim.log.levels.ERROR)
        end)
        return
      end

      vim.schedule(function()
        vim.ui.select(all_tsconfigs, { prompt = "Choose tsconfig.json to run:" }, function(choice)
          if choice then
            run_tsc_build(choice)
          else
            vim.notify("Cancelled tsconfig selection.", vim.log.levels.WARN)
          end
        end)
      end)
    end,
  })
end

vim.keymap.set("n", "<leader>xp", pick_tsconfig_and_run, { desc = "Choose tsconfig.json and run TypeScript check" })
