-- https://github.com/JoosepAlviste/dotfiles/blob/master/config/nvim/lua/j/plugins/telescope.lua
return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "natecraddock/telescope-zf-native.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
  },
  opts = function()
    local actions = require("telescope.actions")
    local themes = require("telescope.themes")
    local custom_pickers = require("custom.telescope_custom_pickers")

    return {
      defaults = {
        file_ignore_patterns = { "^.git/.*$" },
        mappings = {
          i = {
            ["<esc>"] = actions.close,

            ["<s-up>"] = actions.cycle_history_prev,
            ["<s-down>"] = actions.cycle_history_next,

            ["<c-w>"] = function()
              vim.api.nvim_input("<c-s-w>")
            end,
            ["<c-u>"] = function()
              vim.api.nvim_input("<c-s-u>")
            end,
            ["<c-a>"] = function()
              vim.api.nvim_input("<home>")
            end,
            ["<c-e>"] = function()
              vim.api.nvim_input("<end>")
            end,

            ["<c-f>"] = actions.preview_scrolling_down,
            ["<c-b>"] = actions.preview_scrolling_up,
          },
        },
      },
      pickers = {
        oldfiles = {
          sort_lastused = true,
          cwd_only = true,
        },
        find_files = {
          hidden = true,
          find_command = {
            "rg",
            "--files",
            "--color",
            "never",
            "--ignore-file",
          },
        },
        live_grep = {
          path_display = { "shorten" },
          mappings = {
            i = {
              ["<c-f>"] = custom_pickers.actions.set_extension,
              ["<c-l>"] = custom_pickers.actions.set_folders,
            },
          },
        },
      },
      extensions = {
        ["ui-select"] = {
          themes.get_cursor({}),
        },
      },
    }
  end,

  config = function(_, opts)
    require("telescope").setup(opts)

    require("telescope").load_extension("zf-native")
    require("telescope").load_extension("ui-select")
  end,

  keys = {
    {
      "<leader>ff",
      function()
        require("custom.telescope_pretty_pickers").pretty_files_picker({ picker = "find_files" })
      end,
    },
    {
      "<leader>/",
      function()
        require("custom.telescope_custom_pickers").live_grep()
      end,
    },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>" },
    {
      "<leader>fr",
      function()
        require("custom.telescope_pretty_pickers").pretty_files_picker({ picker = "oldfiles" })
      end,
    },
    { "<leader>fx", "<cmd>Telescope git_status<cr>" },
    { "<leader>fc", "<cmd>Telescope git_commits<cr>" },
    { "<leader>ca", vim.lsp.buf.code_action },
  },
}
