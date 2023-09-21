return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    opts.ignore_install = { "help" }
    -- opts.highlight = {
    --   enable = true,
    --   additional_vim_regex_highlighting = { "org" },
    -- }
    -- opts.ensure_installed = { "org" }
  end,
}
