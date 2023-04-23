{
  description = "Home Manager config";

  inputs = {
    nixpkgs.url = "flake:nixpkgs";
    homeManager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl.url = "github:guibou/nixGL";
    hyprpaper.url = "github:hyprwm/hyprpaper";
    hyprpicker.url = "github:hyprwm/hyprpicker";
    eww.url = "github:elkowar/eww";
    rust-overlay.url = "github:oxalica/rust-overlay";
    neovim-flake.url = "/home/neoney/code/neovim-flake";
  };

  outputs = {
    nixpkgs,
    homeManager,
    nixgl,
    hyprpaper,
    hyprpicker,
    eww,
    rust-overlay,
    neovim-flake,
    ...
  } @ inputs: let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      system = system;
      overlays = [nixgl.overlay hyprpaper.overlays.default hyprpicker.overlays.default eww.overlays.default rust-overlay.overlays.default];
      allowUnfree = true;
    };

    macbookVars = import ./vars/macbook.nix;
    archVars = import ./vars/arch.nix;
  in {
    homeConfigurations = {
      "neoney@macbook" = homeManager.lib.homeManagerConfiguration {
        pkgs = pkgs;
        modules = [
          ./home.nix
        ];

        extraSpecialArgs = {
          inherit inputs neovim-flake;
          vars = macbookVars;
          utils = import ./utils.nix {
            inherit inputs;
            pkgs = pkgs;
            lib = pkgs.lib;
            vars = macbookVars;
          };
        };
      };
      "neoney@arch" = homeManager.lib.homeManagerConfiguration {
        pkgs = pkgs;
        modules = [
          ./home.nix
        ];

        extraSpecialArgs = {
          inherit inputs neovim-flake;
          vars = archVars;
          utils = import ./utils.nix {
            inherit inputs;
            pkgs = pkgs;
            lib = pkgs.lib;
            vars = archVars;
          };
        };
      };
    };
  };
}
