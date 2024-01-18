return {
  "sindrets/diffview.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
  },
  keys = {
    { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open Git in Diffview" },
    { "<leader>gq", "<cmd>DiffviewClose<cr>", desc = "Close Git Diffview" },
    { "<leader>gh", "<cmd>DiffviewFileHistory<cr>", desc = "History for the current branch" },
    { "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", desc = "History for the current file" },
  },
}
