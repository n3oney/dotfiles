{
  description = "Home Manager config";

  inputs = {
    nixpkgs.url = "flake:nixpkgs";
    homeManager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixgl.url = "github:guibou/nixGL";
  };

  outputs = {
    self,
    nixpkgs,
    homeManager,
    nixgl,
    ...
  } @ inputs: let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      system = system;
      overlays = [nixgl.overlay];
      allowUnfree = true;
    };

    macbookVars = import ./vars-macbook.nix;
    archVars = import ./vars-arch.nix;
  in {
    homeConfigurations = {
      "neoney@macbook" = homeManager.lib.homeManagerConfiguration {
        pkgs = pkgs;
        modules = [
          ./home.nix
        ];

        extraSpecialArgs = {
          inherit inputs;
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
          inherit inputs;
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
