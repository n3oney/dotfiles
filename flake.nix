{
  description = "Home Manager config";

  inputs = {
    nixpkgs.url = "flake:nixpkgs";
    homeManager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl.url = "github:guibou/nixGL";
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = {
    self,
    nixpkgs,
    homeManager,
    nixgl,
    hyprland,
    ...
  } @ inputs: let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      system = system;
      overlays = [nixgl.overlay];
      allowUnfree = true;
    };
  in {
    homeConfigurations = {
      "neoney@macbook" = homeManager.lib.homeManagerConfiguration {
        pkgs = pkgs;
        modules = [
          hyprland.homeManagerModules.default
          ./home.nix
        ];

        extraSpecialArgs = {
          inherit inputs;
          hyprland = hyprland;
          utils = import ./utils.nix {
            inherit inputs;
            pkgs = pkgs;
            lib = pkgs.lib;
          };
          vars = import ./vars.nix;
        };
      };
    };
  };
}
