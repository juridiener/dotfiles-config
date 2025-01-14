return {
  {
    "vhyrro/luarocks.nvim",
    priority = 1000, -- We'd like this plugin to load first out of the rest
    config = true, -- This automatically runs `require("luarocks-nvim").setup()`
  },
  {

    "nvim-neorg/neorg",
    dependencies = { "luarocks.nvim" },
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
              default_workspace = "work",
            },
          },
          ["core.export"] = {},
          ["core.summary"] = {},
          -- ["core.completion"] = {
          --   config = {
          --     engine = "nvim-cmp",
          --     name = "[Neorg]",
          --   },
          -- },
          -- ["core.keybinds"] = {
          --   config = {
          --     neorg_leader = " ",
          --   },
          -- },
        },
      })
    end,
  },
}
