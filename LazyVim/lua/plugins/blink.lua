return {
  "saghen/blink.cmp",
  dependencies = { "archie-judd/blink-cmp-words" },
  opts = {
    keymap = {
      preset = "enter",
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      ["<A-k>"] = { "scroll_documentation_up" },
      ["<A-j>"] = { "scroll_documentation_down" },
    },
    completion = {
      list = {
        selection = { auto_insert = true, preselect = true },
      },
    },
    sources = {
      -- vailable in all filetypes by default
      default = { "lsp", "path", "lazydev", "dictionary", "thesaurus" },

      -- default = { "lsp", "path", "lazydev" }, -- add any sources you want
      providers = {
        -- neorg = {
        --   name = "neorg",
        --   enabled = function()
        --     return vim.bo.filetype == "norg"
        --   end,
        -- },
        thesaurus = {
          name = "blink-cmp-words",
          module = "blink-cmp-words.thesaurus",
          opts = {
            score_offset = 0,
            pointer_symbols = { "!", "&", "^" },
          },
        },
        dictionary = {
          name = "blink-cmp-words",
          module = "blink-cmp-words.dictionary",
          opts = {
            dictionary_search_threshold = 3,
            score_offset = 0,
            pointer_symbols = { "!", "&", "^" },
          },
        },
      },
      -- per_filetype = {
      --   text = { "dictionary" },
      --   markdown = { "thesaurus" },
      --   javascript = { "dictionary", "thesaurus" },
      --   typescript = { "dictionary", "thesaurus" },
      -- },
    },
  },
}
