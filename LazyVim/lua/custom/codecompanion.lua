return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim",
      {
        "stevearc/dressing.nvim",
      },
    },

    config = function()
      local ollama_fn = function()
        return require("codecompanion.adapters").extend("ollama", { schema = { model = { default = "llama3.1" } } })
      end

      require("codecompanion").setup({
        adapters = {
          ollama = ollama_fn,
        },
        strategies = {
          chat = {
            adapter = "ollama",
          },
          inline = {
            adapter = "ollama",
          },
          agent = {
            adapter = "ollama",
          },
        },
      })
    end,
  },
}
