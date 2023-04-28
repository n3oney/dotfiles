### deprecated, see `foot.nix`
{
  vars,
  utils,
  pkgs,
  ...
}: {
  programs.wezterm = {
    enable = true;
    package = utils.nixGLWrap pkgs.wezterm;
    extraConfig = ''
      local wezterm = require("wezterm")

      local config = {}

      if wezterm.config_builder then
        config = wezterm.config_builder()
      end

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

       -- Special listener so that I can have a non-transparent background when in neovim
       -- in nvim, only the border is transparent, and while I could override it to be the whole BG, that's too distracting
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

      config.font = wezterm.font("monospace")
      config.font_size = ${toString vars.term_font_size}
      config.term = "wezterm"
      config.force_reverse_video_cursor = true
      config.colors = colors
      config.freetype_load_target = "Light"
      config.window_background_opacity = 0.7
      config.enable_tab_bar = false
      config.default_cursor_style = "SteadyBar"

      return config
    '';
  };
}
