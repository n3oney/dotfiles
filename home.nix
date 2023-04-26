{
  pkgs,
  neovim-flake,
  ...
} @ inputs: {
  home.username = "neoney";
  home.homeDirectory = "/home/neoney";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;

  imports = [
    neovim-flake.homeManagerModules.default
    ./hyprland.nix
    ./wezterm.nix
    ./fonts.nix
    ./starship.nix
    ./fish.nix
    ./eww
    ./neovim.nix
    ./anyrun.nix
  ];

  home.packages = with pkgs; [
    neofetch
    alejandra

    nixgl.nixGLIntel
  ];

  programs.mpv.enable = true;

  programs.git = {
    enable = true;
    userName = "n3oney";
    userEmail = "neo@neoney.dev";
    extraConfig = {
      user.signingKey = "0x1261173A01E10298";
      commit.gpgSign = true;
      pull.rebase = true;
      init.defaultBranch = "main";
    };
  };

  home.stateVersion = "22.11";
  programs.home-manager.enable = true;
}
