return {
  "sindrets/diffview.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
  },
  opts = {
    view = {
      merge_tool = {
        layout = "diff3_mixed",
      },
    },
  },
  keys = {
    { "<leader>gdd", "<cmd>DiffviewOpen<cr>", desc = "Open Git in Diffview" },
    { "<leader>gdr", "<cmd>DiffviewOpen origin/main...HEAD<cr>", desc = "Check remote main with current" },
    { "<leader>gdc", "<cmd>DiffviewOpen HEAD...origin/main<cr>", desc = "Check current with remote main" },
    { "<leader>gdq", "<cmd>DiffviewClose<cr>", desc = "Close Git Diffview" },
    { "<leader>gdH", "<cmd>DiffviewFileHistory<cr>", desc = "History for the current branch" },
    { "<leader>gdh", "<cmd>DiffviewFileHistory %<cr>", desc = "History for the current file" },
  },
}
