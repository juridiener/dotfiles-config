-- SHIFT+CTRL+L = Debug Mode
-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local numpanes = ""
	if #tab.panes > 1 then
		numpanes = "(" .. tostring(#tab.panes) .. ") "
	end
	return numpanes .. tab.active_pane.title
end)

-- format window title
wezterm.on("format-window-title", function(tab, pane, tabs, panes, config)
	local numtabs = ""
	if #tabs > 1 then
		numtabs = "(" .. tostring(#tabs) .. ") "
	end
	return numtabs .. tab.active_pane.title
end)

-- wezterm.on("gui-startup", function()
-- 	local tab, pane, window = mux.spawn_window({})
-- 	window:gui_window():maximize()
--
-- 	local args = {}
-- 	if cmd then
-- 		args = cmd.args
-- 	end
--
-- 	-- Set a workspace for coding on a current project
-- 	-- Top pane is for the editor, bottom pane is for the build tool
-- 	local config_cwd = "~/.config/"
-- 	local tab, build_pane, window = mux.spawn_window({
-- 		workspace = "config",
-- 		cwd = config_cwd,
-- 		args = args,
-- 	})
-- 	-- local editor_pane = build_pane:split {
-- 	--   direction = 'Top',
-- 	--   size = 0.6,
-- 	--   cwd = project_dir,
-- 	-- }
--
-- 	-- A workspace for interacting with a local machine that
-- 	-- runs some docker containners for home automation
-- 	--
-- 	local tab, pane, window = mux.spawn_window({
-- 		workspace = "dev",
-- 		cwd = "~/Documents/dev/",
-- 	})
--
-- 	-- We want to startup in the coding workspace
-- 	mux.set_active_workspace("dev")
-- end)

-- wezterm.on("new-tab-button-click", function(window, pane, button, default_action)
-- 	-- just log the default action and allow wezterm to perform it
-- 	wezterm.log_info("new-tab", window, pane, button, default_action)
-- end)

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.window_padding = {
	left = 11,
	right = 0,
	top = 0,
	bottom = 0,
}

config.font = wezterm.font("JetBrainsMono Nerd Font")
config.font_size = 14.0
config.adjust_window_size_when_changing_font_size = false
config.color_scheme = "Gruvbox dark, medium (base16)"

-- config.window_background_image = '/path/to/wallpaper.jpg'
config.window_background_opacity = 1.0

config.window_frame = {
	font_size = 14.0,

	-- The overall background color of the tab bar when
	-- the window is focused
	active_titlebar_bg = "#282828",

	-- The overall background color of the tab bar when
	-- the window is not focused
	inactive_titlebar_bg = "#282828",
}

config.colors = {
	tab_bar = {
		inactive_tab_edge = "#575757",
		active_tab = {
			bg_color = "#282828",
			fg_color = "#cc241d",
			-- Specify whether you want "Half", "Normal" or "Bold" intensity for the
			intensity = "Bold",
		},
	},
}
config.inactive_pane_hsb = {
	brightness = 0.5,
}

-- Wird vermutlich als default bei mac genommen
-- config.default_prog = { "/usr/local/bin/zsh", "-l" }

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2044 }
config.keys = {
	{ key = "=", mods = "CTRL", action = act.ResetFontSize },
	{
		key = "|",
		mods = "LEADER|SHIFT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "_",
		mods = "LEADER|SHIFT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "LeftArrow",
		mods = "SHIFT",
		action = act.AdjustPaneSize({ "Left", 5 }),
	},
	{
		key = "DownArrow",
		mods = "SHIFT",
		action = act.AdjustPaneSize({ "Down", 5 }),
	},
	{
		key = "UpArrow",
		mods = "SHIFT",
		action = act.AdjustPaneSize({ "Up", 5 }),
	},
	{
		key = "RightArrow",
		mods = "SHIFT",
		action = act.AdjustPaneSize({ "Right", 5 }),
	},
	{
		key = "0",
		mods = "LEADER",
		action = act.PaneSelect({
			alphabet = "1234567890",
		}),
	},

	{
		key = "UpArrow",
		mods = "ALT",
		action = act.ScrollByLine(-3),
	},
	{
		key = "DownArrow",
		mods = "ALT",
		action = act.ScrollByLine(3),
	},
	{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
	{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
	{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
	{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
	{
		key = "x",
		mods = "LEADER",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	{
		key = "f",
		mods = "LEADER",
		action = wezterm.action.ToggleFullScreen,
	},
	{
		key = "=",
		mods = "LEADER",
		action = wezterm.action.TogglePaneZoomState,
	},
	{
		key = "s",
		mods = "LEADER",
		action = act.ShowLauncherArgs({
			flags = "WORKSPACES",
		}),
	},
	{
		key = "w",
		mods = "LEADER",
		action = act.PromptInputLine({
			description = wezterm.format({
				{ Attribute = { Intensity = "Bold" } },
				{ Foreground = { AnsiColor = "Fuchsia" } },
				{ Text = "Enter name for new workspace" },
			}),
			action = wezterm.action_callback(function(window, pane, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					window:perform_action(
						act.SwitchToWorkspace({
							name = line,
						}),
						pane
					)
				end
			end),
		}),
	},
}

-- to switsch to a tab on pressing leader+num
for i = 1, 8 do
	-- CTRL+ALT + number to activate that tab
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = act.ActivateTab(i - 1),
	})
end

-- and finally, return the configuration to wezterm
return config
