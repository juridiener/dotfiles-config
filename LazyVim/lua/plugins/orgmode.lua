return {
  {
    "nvim-orgmode/orgmode",
    lazy = false,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("orgmode").setup({
        org_agenda_files = {
          "~/.config/notes/index.org",
        },
        org_default_notes_file = "~/.config/notes/refile.org",
        org_todo_keywords = { "TODO", "IN-PROGRESS", "DONE" },
        org_capture_templates = {
          t = {
            description = "Todo",
            template = "* TODO %?\n  %u",
            target = "~/Documents/notes/todo.org",
          },
          j = {
            description = "Journal",
            template = "\n*** %<%Y-%m-%d> %<%A>\n**** %U\n\n%?",
            target = "~/Documents/notes/journal.org",
          },
          n = {
            description = "Notes",
            template = "* %?\n  %u",
            target = "~/.config/notes/index.org",
          },
        },
        org_completion = {
          enabled = true,
        },
        org_agenda_custom_commands = {
          c = {
            description = "Custom Agenda View",
            command = 'tags-todo "PROJECT"',
          },
        },
      })

      vim.wo.foldlevel = 99
      vim.wo.conceallevel = 2
    end,
  },
}
