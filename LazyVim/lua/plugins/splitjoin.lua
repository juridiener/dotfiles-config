return {
  "nvim-mini/mini.splitjoin",
  version = "*",
  config = function()
    require("mini.splitjoin").setup({
      mappings = {
        toggle = "gs",
      },
    })
  end,
}
