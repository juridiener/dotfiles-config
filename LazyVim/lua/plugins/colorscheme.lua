return {
  {
    "olivercederborg/poimandres.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("poimandres").setup({
        -- leave this setup function empty for default config
        -- or refer to the configuration section
        -- for configuration options
      })
    end,
  },
  -- {"Yazeed1s/oh-lucy.nvim"},
  -- {"kvrohit/substrata.nvim"},
  -- {"olivercederborg/poimandres.nvim"},
  -- {"aliqyan-21/darkvoid.nvim"},
  { "RRethy/base16-nvim" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "base16-rose-pine",
    },
  },
}
