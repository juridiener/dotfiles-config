return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false, -- set this if you want to always pull the latest change
  opts = {
    provider = "copilot",
    auto_suggestions_provider = "copilot",
    debug = true,
    -- vendors = {
    --   ---@type AvanteProvider
    --   ollama = {
    --     ["local"] = true,
    --     endpoint = "127.0.0.1:11434",
    --     model = "mistral",
    --     -- model = "deepseek-coder-v2",
    --     parse_curl_args = function(opts, code_opts)
    --       return {
    --         url = opts.endpoint .. "/chat/completions",
    --         headers = {
    --           ["Accept"] = "application/json",
    --           ["Content-Type"] = "application/json",
    --         },
    --         body = {
    --           model = opts.model,
    --           messages = require("avante.providers").copilot.parse_message(code_opts), -- you can make your own message, but this is very advanced
    --           max_tokens = 2048,
    --           stream = true,
    --         },
    --       }
    --     end,
    --     parse_response_data = function(data_stream, event_state, opts)
    --       require("avante.providers").openai.parse_response(data_stream, event_state, opts)
    --     end,
    --   },
    -- },
  },
  -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  build = "make",
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    {
      "zbirenbaum/copilot.lua",
      cmd = "Copilot",
      event = "InsertEnter",
      config = function()
        require("copilot").setup({
          panel = {
            enabled = true,
            auto_refresh = false,
            keymap = {
              jump_prev = "[[",
              jump_next = "]]",
              accept = "<CR>",
              refresh = "gr",
              open = "<M-CR>",
            },
            layout = {
              position = "bottom", -- | top | left | right
              ratio = 0.4,
            },
          },
          suggestion = {
            enabled = true,
            auto_trigger = true,
            hide_during_completion = true,
            debounce = 75,
            keymap = {
              accept = "<M-l>",
              accept_word = false,
              accept_line = false,
              next = "<M-]>",
              prev = "<M-[>",
              dismiss = "<C-]>",
            },
          },
          filetypes = {
            yaml = false,
            markdown = false,
            help = false,
            gitcommit = false,
            gitrebase = false,
            hgcommit = false,
            svn = false,
            cvs = false,
            ["."] = false,
          },
          copilot_node_command = "node", -- Node.js version must be > 18.x
          server_opts_overrides = {},
        })
      end,
    },
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
