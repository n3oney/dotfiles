local wezterm = require("wezterm")

-- Doing this so I can (possibly) override some values in the future.
local tokyo = wezterm.get_builtin_color_schemes()["TokyoNightStorm (Gogh)"]

wezterm.on("user-var-changed", function(window, pane, name, value)
	if name == "nvim_open" then
		local overrides = window:get_config_overrides() or {}

		if value == "yes" then
			overrides.window_background_opacity = 1
		else
			overrides.window_background_opacity = 0.7
		end

		window:set_config_overrides(overrides)
	end
end)

return {
	font = wezterm.font("monospace"),
	font_size = 10.5,
	term = "wezterm",
	force_reverse_video_cursor = true,
	colors = tokyo,
	freetype_load_target = "Light",
	window_background_opacity = 0.7,
	enable_tab_bar = false,
	default_cursor_style = "SteadyBar",
}
