# Rename this file to vars.nix, and set the values.
{
  main_monitor = "eDP-1";
  main_width = 1440;
  main_height = 900;
  secondary_monitor = "DP-3"; # Optional.
  main_wallpaper = /home/neoney/Wallpapers/nice-image.jpg;
  secondary_wallpaper = /home/neoney/Wallpapers/nice-image.jpg; # Optional
  mouse_sensitivity = -0.3;
  keyboards = [
    "keyboard-name"
  ];
  area_screenshot_keybind = ", XF86LaunchA";
  active_screenshot_keybind = ", XF86LaunchB";
  term_font_size = 7;
  mono_font = "Cozette";
  sans_font = "gg sans";
  windows = false;
  active_border = "F5F4F9";
  inactive_border = "2B2937";
  secondary_sink = "alsa_output.pci-0000_00_1b.0.analog-stereo"; # Optional
}
