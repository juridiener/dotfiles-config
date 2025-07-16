return {
  "tanvirtin/vgit.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = { "BufReadPre", "BufNewFile" }, -- only load when a file is read or created
  config = function()
    require("vgit").setup()
  end,
}
