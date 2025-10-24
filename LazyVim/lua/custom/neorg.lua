return {
  {
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
  },
  {

    "nvim-neorg/neorg",
    lazy = false,
    dependencies = { "nvim-treesitter/nvim-treesitter", "vhyrro/luarocks.nvim" },
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.concealer"] = {
            config = {
              icon_preset = "basic",
            },
          }, -- Adds pretty icons to your documents
          ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
              workspaces = {
                notes = "~/Documents/notes",
                work = "~/Documents/notes/work",
                private = "~/Documents/notes/private",
              },
              default_workspace = "notes",
            },
          },
          ["core.export"] = {},
          ["core.summary"] = {},
          ["core.syntax"] = {},
          -- ["core.completion"] = {
          -- config = {
          --   engine = "blink", -- currently not supported
          -- },
          -- },
          -- ["core.keybinds"] = {
          --   config = {
          --     neorg_leader = " ",
          --   },
          -- },
        },
      })
      vim.wo.foldlevel = 99
      vim.wo.conceallevel = 2
    end,
  },
}
