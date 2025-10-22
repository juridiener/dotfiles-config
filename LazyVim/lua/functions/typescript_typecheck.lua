local M = {}

function M.run_tsc_build(tsconfig_path)
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
          vim.keymap.set("n", "q", function()
            vim.cmd("Trouble quickfix close")
            vim.keymap.del("n", "q")
          end, { silent = true, desc = "Close TypeScript Trouble" })
        end)
      end
    end,
  })
end

function M.pick_tsconfig_and_run()
  local all_tsconfigs = {}
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
            M.run_tsc_build(choice)
          else
            vim.notify("Cancelled tsconfig selection.", vim.log.levels.WARN)
          end
        end)
      end)
    end,
  })
end

return M
