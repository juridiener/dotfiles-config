-- defaults: https://github.com/nvim-orgmode/orgmode/blob/master/lua/orgmode/config/defaults.lua
-- config https://github.com/nvim-orgmode/orgmode/blob/master/DOCS.md#getting-started-with-orgmode

local orgmode_ok, orgmode = pcall(require, "orgmode")
if not orgmode_ok then
  print('orgmode not avaible')
  return
end

orgmode.setup_ts_grammar()

orgmode.setup({
  org_agenda_files = {'~/Documents/org-files/**/*'},
  org_default_notes_file = '~/Documents/org-files/refile.org',
  org_capture_templates = {
    t = {
      description = 'Todo',
      template = '* TODO %?\n%U',
      target = '~/Documents/org-files/todo.org'
    },
    j = {
      description = 'Journal',
      template = '\n*** %<%Y-%m-%d> %<%A>\n**** %U\n\n%?',
      target = '~/Documents/org-files/journal.org'
    },
    n = {
      description = 'Notes',
      template = '* %?\n %u',
      target = '~/Documents/org-files/notes.org'
    }
  },
  mappings = {
    org = {
      org_toggle_checkbox = '<C-Space>',
    }
  }
})
