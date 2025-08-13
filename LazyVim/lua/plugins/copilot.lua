return {
  "zbirenbaum/copilot.lua",
  config = function(_, opts)
    -- customize opts if needed
    opts.suggestion = opts.suggestion or {}
    opts.suggestion.enabled = true
    opts.suggestion.auto_trigger = true
    opts.suggestion.trigger_on_accept = true
    opts.suggestion.keymap = {
      accept = "<M-a>",
      next = "<M-]>",
      prev = "<M-[>",
      accept_word = false,
      accept_line = false,
      dismiss = "<M-c>",
    }
    opts.panel = opts.panel or {}
    opts.panel.enabled = false
    require("copilot").setup(opts)
  end,
}
