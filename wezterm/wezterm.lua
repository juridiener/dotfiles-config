-- SHIFT+CTRL+L = Debug Mode
-- Pull in the wezterm API
local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux

wezterm.on("gui-startup", function()
	local home = os.getenv("HOME")
	local react_tab, react_pane, react_window = mux.spawn_window({
		cwd = home .. "/Documents/projects/hains/hains_docker/dienstplaner/",
		workspace = "REACT",
	})

	react_window:gui_window():maximize()
	react_tab:set_title("REACT")

	local ws_api_tab, ws_api_pane, ws_api_window = mux.spawn_window({
		cwd = home .. "/Documents/projects/hains/hains_docker/HAINS-api/",
		workspace = "API",
	})
	ws_api_tab:set_title("API")
	ws_api_pane:split({ direction = "Right", size = 0.1 })
	ws_api_tab:activate()
	ws_api_pane:activate()

	local ws_joomla_tab, ws_joomla_pane, ws_joomla_window = mux.spawn_window({
		cwd = home .. "/Documents/projects/hains/hains_docker/hains_joomla/joomla/hains",
		workspace = "JOOMLA",
	})

	local ws_docker_tab, ws_docker_pane, ws_docker_window = mux.spawn_window({
		cwd = home .. "/Documents/projects/hains/hains_docker/",
		workspace = "DOCKER",
	})
	ws_docker_tab:set_title("DOCKER")

	local ws_server_tab, ws_server_pane, ws_server_window = mux.spawn_window({
		cwd = home,
		workspace = "SERVER",
	})

	local ws_dev_tab, ws_dev_pane, ws_dev_window = mux.spawn_window({
		cwd = home .. "/Documents/dev/",
		workspace = "DEV",
	})
	ws_dev_tab:set_title("DEV")

	local ws_monorepo_tab, ws_monorepo_pane, ws_monorepo_window = mux.spawn_window({
		cwd = home .. "/Documents/projects/hains/hains_docker/monorepo/",
		workspace = "MONOREPO",
	})
	ws_monorepo_tab:set_title("MONOREPO")

	local ws_config_tab, ws_config_pane, ws_config_window = mux.spawn_window({
		cwd = home .. "/.config/",
		workspace = "CONFIG",
	})
	ws_config_tab:set_title("CONFIG")

	react_tab:activate()

	local ws_api_tab2 = ws_api_window:spawn_tab({})
	ws_api_tab2:set_title("Tab2")

	mux.set_active_workspace("REACT")
end)

-- Main config
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.audible_bell = "Disabled"
-- config.debug_key_events = true
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true

config.window_padding = {
	left = 0,
	right = 0,
	top = 11,
	bottom = 0,
}

config.enable_scroll_bar = true
config.scrollback_lines = 70000

config.font = wezterm.font("JetBrainsMono Nerd Font", { italic = true })
config.font_size = 17.0
config.adjust_window_size_when_changing_font_size = false
config.color_scheme = "Rosé Pine (base16)"
config.max_fps = 120

config.colors = {
	tab_bar = {
		background = "#1b1e28",
		active_tab = { bg_color = "#1b1e28", fg_color = "#a6accd" },
		inactive_tab = { bg_color = "#1b1e28", fg_color = "#767c9d" },
		inactive_tab_hover = { bg_color = "#1b1e28", fg_color = "#a6accd" },
		new_tab = { bg_color = "#1b1e28", fg_color = "#767c9d" },
		new_tab_hover = { bg_color = "#1b1e28", fg_color = "#a6accd", italic = true },
	},
}

config.window_background_opacity = 1
config.inactive_pane_hsb = { brightness = 0.90 }

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2044 }

config.keys = {
	{ key = "=", mods = "CTRL", action = act.ResetFontSize },
	{ key = "|", mods = "LEADER|SHIFT", action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
	{ key = "_", mods = "LEADER|SHIFT", action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }) },
	{ key = "LeftArrow", mods = "SHIFT", action = act.AdjustPaneSize({ "Left", 5 }) },
	{ key = "DownArrow", mods = "SHIFT", action = act.AdjustPaneSize({ "Down", 5 }) },
	{ key = "UpArrow", mods = "SHIFT", action = act.AdjustPaneSize({ "Up", 5 }) },
	{ key = "RightArrow", mods = "SHIFT", action = act.AdjustPaneSize({ "Right", 5 }) },
	{ key = "0", mods = "LEADER", action = act.PaneSelect({ alphabet = "1234567890" }) },
	{ key = "UpArrow", mods = "ALT", action = act.ScrollByLine(-3) },
	{ key = "DownArrow", mods = "ALT", action = act.ScrollByLine(3) },
	{ key = "UpArrow", mods = "ALT|SHIFT", action = act.ScrollByLine(-24) },
	{ key = "DownArrow", mods = "ALT|SHIFT", action = act.ScrollByLine(24) },
	{ key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
	{ key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
	{ key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
	{ key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
	{ key = "x", mods = "LEADER", action = wezterm.action.CloseCurrentPane({ confirm = true }) },
	{ key = "f", mods = "LEADER", action = wezterm.action.ToggleFullScreen },
	{ key = "=", mods = "LEADER", action = wezterm.action.TogglePaneZoomState },
	{
		key = "s",
		mods = "LEADER",
		action = act.ShowLauncherArgs({ flags = "WORKSPACES" }),
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
				if line then
					window:perform_action(act.SwitchToWorkspace({ name = line }), pane)
				end
			end),
		}),
	},
}

-- Leader+Number tab switch
for i = 1, 8 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = act.ActivateTab(i - 1),
	})
end

-- Force Option+A to send <M-a> (ESC + a) for Neovim
table.insert(config.keys, {
	key = "a",
	mods = "ALT",
	action = wezterm.action.SendString("\x1ba"),
})

return config
