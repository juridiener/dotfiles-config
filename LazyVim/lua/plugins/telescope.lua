--https://github.com/nvim-telescope/telescope.nvim/issues/2201
local ts_select_dir_for_grep = function(prompt_bufnr)
  local action_state = require("telescope.actions.state")
  local fb = require("telescope").extensions.file_browser
  local live_grep = require("telescope.builtin").live_grep
  local current_line = action_state.get_current_line()

  fb.file_browser({
    files = false,
    depth = false,
    attach_mappings = function(prompt_bufnr)
      require("telescope.actions").select_default:replace(function()
        local entry_path = action_state.get_selected_entry().Path
        local dir = entry_path:is_dir() and entry_path or entry_path:parent()
        local relative = dir:make_relative(vim.fn.getcwd())
        local absolute = dir:absolute()

        live_grep({
          results_title = relative .. "/",
          cwd = absolute,
          default_text = current_line,
        })
      end)

      return true
    end,
  })
end

return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-telescope/telescope-file-browser.nvim",
    build = "make",
    config = function()
      require("telescope").load_extension("file_browser")
    end,
  },
  keys = {
    {
      "<leader>fs",
      function()
        require("telescope.builtin").lsp_document_symbols({
          -- symbols = require("lazyvim.config").get_kind_filter(),
          symbols = { "function", "method", "constant", "class", "constructor", "interface" },
        })
      end,
      desc = "Goto Symbol",
    },
    {
      "<leader>fS",
      function()
        require("telescope.builtin").lsp_workspace_symbols({
          symbols = { "function", "method", "constant", "class", "constructor", "interface" },
        })
      end,
      desc = "Goto Symbol",
    },
  },

  cmd = "Telescope",

  opts = {
    defaults = {
      -- file_ignore_patterns = { "^.git/.*$", "^.repro/.*$" },
      -- vimgrep_arguments = {
      -- "rg",
      -- "--follow", -- Follow symbolic links
      -- "--hidden", -- Search for hidden files
      -- "--no-heading", -- Don't group matches by each file
      -- "--with-filename", -- Print the file path with the matched lines
      -- "--line-number", -- Show line numbers
      -- "--column", -- Show column numbers
      -- "--smart-case", -- Smart case search

      -- Exclude some patterns from search
      -- "--glob=!**/.git/*",
      -- "--glob=!**/.idea/*",
      -- "--glob=!**/.vscode/*",
      -- "--glob=!**/.repro/*",
      -- "--glob=!**/LazyVim/.repro/*",
      -- "--glob=!**/build/*",
      -- "--glob=!**/dist/*",
      -- "--glob=!**/yarn.lock",
      -- "--glob=!**/package-lock.json",
      -- },
      layout_strategy = "vertical",
      -- layout_config = { height = 10 },
      -- layout_config = { prompt_position = "top" },
      sorting_strategy = "ascending",
      -- winblend = 0,
      mappings = {
        i = {
          ["<A-j>"] = function(bufnr)
            return require("telescope.actions").preview_scrolling_down(bufnr)
          end,
          ["<A-k>"] = function(bufnr)
            return require("telescope.actions").preview_scrolling_up(bufnr)
          end,
          ["<A-h>"] = function(bufnr)
            return require("telescope.actions").preview_scrolling_left(bufnr)
          end,
          ["<A-l>"] = function(bufnr)
            return require("telescope.actions").preview_scrolling_right(bufnr)
          end,
        },
        n = {
          ["<A-j>"] = function(bufnr)
            return require("telescope.actions").preview_scrolling_down(bufnr)
          end,
          ["<A-k>"] = function(bufnr)
            return require("telescope.actions").preview_scrolling_up(bufnr)
          end,
          ["<A-h>"] = function(bufnr)
            return require("telescope.actions").preview_scrolling_left(bufnr)
          end,
          ["<A-l>"] = function(bufnr)
            return require("telescope.actions").preview_scrolling_right(bufnr)
          end,
        },
      },
    },
    extensions = {
      file_browser = {
        theme = "ivy",
        -- disables netrw and use telescope-file-browser in its place
        hijack_netrw = true,
      },
    },
    pickers = {
      find_files = {
        theme = "dropdown",
        -- hidden = true,
        -- needed to exclude some files & dirs from general search
        -- when not included or specified in .gitignore
        -- find_command = {
        --   "rg",
        --   "--files",
        --   "--hidden",
        --   "--glob=!**/.git/*",
        --   "--glob=!**/.idea/*",
        --   "--glob=!**/.vscode/*",
        --   "--glob=!**/.repro/*",
        --   "--glob=!**/LazyVim/.repro/*",
        --   "--glob=!**/build/*",
        --   "--glob=!**/dist/*",
        --   "--glob=!**/yarn.lock",
        --   "--glob=!**/package-lock.json",
        -- },
      },
      live_grep = {
        mappings = {
          i = {
            ["<C-b>"] = ts_select_dir_for_grep,
          },
          n = {
            ["<C-b>"] = ts_select_dir_for_grep,
          },
        },
      },
    },
  },
}
