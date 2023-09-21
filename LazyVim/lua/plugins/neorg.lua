return {
  "nvim-neorg/neorg",
  build = ":Neorg sync-parsers",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-neorg/neorg-telescope" },
  config = function()
    require("neorg").setup({
      load = {
        ["core.defaults"] = {}, -- Loads default behaviour
        ["core.concealer"] = {}, -- Adds pretty icons to your documents
        ["core.dirman"] = { -- Manages Neorg workspaces
          config = {
            workspaces = {
              notes = "~/Documents/notes",
              work = "~/Documents/notes/work",
            },
            index = "index.norg",
            default_workspaces = "work",
          },
        },
        ["core.export"] = {},
        ["core.summary"] = {},
        ["core.integrations.telescope"] = {},
      },
    })
  end,
}
