{
  pkgs,
  neovim-flake,
  ...
}: {
  home.username = "neoney";
  home.homeDirectory = "/home/neoney";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;

  imports = [
    neovim-flake.homeManagerModules.default
    ./hyprland.nix
    ./foot.nix
    ./fonts.nix
    ./starship.nix
    ./fish.nix
    ./eww
    ./neovim.nix
    ./anyrun.nix
    ./discord.nix
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = 1;
  };

  home.packages = with pkgs; [
    neofetch
    alejandra
    jaq

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
