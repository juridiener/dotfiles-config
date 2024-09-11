-- #######################################
-- ### USAGE: nvim --clean -u mini.lua ###
-- #######################################

local root = vim.fn.stdpath("run") .. "/nvim/diffview.nvim"
local plugin_dir = root .. "/plugins"
vim.fn.mkdir(plugin_dir, "p")

for _, name in ipairs({ "config", "data", "state", "cache" }) do
  vim.env[("XDG_%s_HOME"):format(name:upper())] = root .. "/" .. name
end

local plugins = {
  { "nvim-web-devicons", url = "https://github.com/nvim-tree/nvim-web-devicons.git" },
  { "diffview.nvim", url = "https://github.com/sindrets/diffview.nvim.git" },
  -- ##################################################################
  -- ### ADD PLUGINS THAT ARE _NECESSARY_ FOR REPRODUCING THE ISSUE ###
  -- ##################################################################
}

for _, spec in ipairs(plugins) do
  local install_path = plugin_dir .. "/" .. spec[1]
  if vim.fn.isdirectory(install_path) ~= 1 then
    if spec.url then
      print(string.format("Installing '%s'...", spec[1]))
      vim.fn.system({ "git", "clone", "--depth=1", spec.url, install_path })
    end
  end
  vim.opt.runtimepath:append(spec.path or install_path)
end

require("diffview").setup({
  -- ##############################################################################
  -- ### ADD DIFFVIEW.NVIM CONFIG THAT IS _NECESSARY_ FOR REPRODUCING THE ISSUE ###
  -- ##############################################################################
})

vim.opt.termguicolors = true
vim.cmd("colorscheme " .. (vim.fn.has("nvim-0.8") == 1 and "habamax" or "slate"))

-- ############################################################################
-- ### ADD INIT.LUA SETTINGS THAT ARE _NECESSARY_ FOR REPRODUCING THE ISSUE ###
-- ############################################################################

print("Ready!")
