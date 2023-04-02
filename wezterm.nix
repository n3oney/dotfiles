{vars, utils, pkgs, ...}: {
  programs.wezterm = {
    enable = true;
    package = utils.nixGLWrap pkgs.wezterm;
    extraConfig = ''
      local wezterm = require("wezterm")

      -- Doing this so I can (possibly) override some values in the future.
      local colors = {
        ansi = {
          "#090618",
          "#c34043",
          "#76946a",
          "#c0a36e",
          "#7e9cd8",
          "#957fb8",
          "#6a9589",
          "#dcd7ba",
        },
        background = "#1f1f28",
        brights = {
          "#727169",
          "#e82424",
          "#98bb6c",
          "#e6c384",
          "#7fb4ca",
          "#938aa9",
          "#7aa89f",
          "#c8c093",
        },
        cursor_bg = "#dcd7ba",
        cursor_border = "#dcd7ba",
        cursor_fg = "#dcd7ba",
        foreground = "#dcd7ba",
        indexed = {},
       }

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
      	font_size = ${toString vars.term_font_size},
      	term = "wezterm",
      	force_reverse_video_cursor = true,
      	colors = colors,
      	freetype_load_target = "Light",
      	window_background_opacity = 0.7,
      	enable_tab_bar = false,
      	default_cursor_style = "SteadyBar",
      }
    '';
  };
}
