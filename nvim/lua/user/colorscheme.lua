-- local status_ok, colorbuddy = pcall(require, "colorbuddy")
-- if not status_ok then
--   return
-- end
--
-- colorbuddy.colorscheme('gruvbuddy')

local colorscheme = "gruvbox-material"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end
