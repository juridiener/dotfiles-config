return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    lazy = false, -- Load eagerly to make sure it's available for orgmode
    opts = {
      ensure_installed = {
        "lua",
        "bash",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "php",
        "ruby",
        "python",
        "sql",
        "ssh_config",
        "json",
        "yaml",
        "markdown",
        "markdown_inline",
        "query",
        "regex",
        "vim",
        "org",
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
            ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
          },
          selection_modes = {
            ["@parameter.outer"] = "v",
            ["@function.outer"] = "V",
            ["@class.outer"] = "<c-v>",
          },
        },
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      indent = { enable = true },
    },
  },
}
