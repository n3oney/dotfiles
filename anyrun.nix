{pkgs, ...}: {
  home.packages = [pkgs.anyrun];

  xdg.configFile."anyrun/config.ron".text = ''
    Config(
      // `width` and `vertical_offset` use an enum for the value it can be either:
      // Absolute(n): The absolute value in pixels
      // Fraction(n): A fraction of the width or height of the full screen (depends on exclusive zones and the settings related to them) window respectively

      // How wide the input box and results are.
      width: Absolute(800),

      // Where Anyrun is located on the screen: Top, Center
      position: Top,

      // How much the runner is shifted vertically
      vertical_offset: Fraction(0.3),

      // Hide match and plugin info icons
      hide_icons: false,

      // ignore exclusive zones, f.e. Waybar
      ignore_exclusive_zones: false,

      // Layer shell layer: Background, Bottom, Top, Overlay
      layer: Overlay,

      // Hide the plugin info panel
      hide_plugin_info: true,

      plugins: [
        "${pkgs.anyrun}/lib/libapplications.so",
        "${pkgs.anyrun}/lib/librink.so",
        "${pkgs.anyrun}/lib/libtranslate.so",
      ],
    )
  '';

  xdg.configFile."anyrun/style.css".text = ''
    window {
      background: rgba(0, 0, 0, 0.8);
    }

    #match,
    #entry,
    #plugin,
    #main {
      background: transparent;
    }

    #match:selected {
      background: rgba(242, 205, 205, 0.7);
      color: black;
    }

    #match {
      padding: 3px;
      border-radius: 12px;
    }

    #entry {
      box-shadow: none;
      border-radius: 12px;
      border: 1px solid #f2cdcd;
    }

    box#main {
      background: rgba(30, 30, 46, 0.7);
      border-radius: 16px;
      padding: 8px;
    }

    row:first-child {
      margin-top: 6px;
    }
  '';
}
