return {
  "tanvirtin/vgit.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    require("vgit").setup({
      settings = {
        live_blame = {
          enabled = false,
        },
      },
    })
  end,
  keys = {
    {
      "<leader>gvh",
      function()
        require("vgit").buffer_history_preview()
      end,
      desc = "Git history of current file",
      silent = true,
    },
    {
      "<leader>gvl",
      function()
        require("vgit").project_logs_preview()
      end,
      desc = "Project log",
      silent = true,
    },
    {
      "<leader>gvp",
      function()
        require("vgit").project_diff_preview()
      end,
      desc = "Project diff modified files",
      silent = true,
    },
  },
}
