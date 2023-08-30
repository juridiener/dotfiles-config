return {
  "nvim-orgmode/orgmode",
  dependencies = {
    { "nvim-treesitter/nvim-treesitter" },
  },
  config = function()
    require("orgmode").setup_ts_grammar()
    require("nvim-treesitter.configs").setup({
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "org" },
      },
      ensure_installed = { "org" }, -- Or run :TSUpdate org
    })
    require("orgmode").setup({
      org_agenda_files = { "~/Documents/org-files/**/*" },
      org_default_notes_file = "~/Documents/org-files/refile.org",
      org_todo_keywords = { "TODO(t)", "|", "DONE(d)" },
      org_capture_templates = {
        t = {
          description = "Todo",
          template = "* TODO %?\n%U",
          target = "~/Documents/org-files/todo.org",
        },
        j = {
          description = "Journal",
          template = "\n*** %<%Y-%m-%d> %<%A>\n**** %U\n\n%?",
          target = "~/Documents/org-files/journal.org",
        },
        n = {
          description = "Notes",
          template = "* %?\n %u",
          target = "~/Documents/org-files/notes.org",
        },
      },
    })
  end,
}
