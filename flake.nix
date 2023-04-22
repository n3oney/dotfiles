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

    configModule = {
      config.vim = {
        wordWrap = false;
        theme = {
          enable = true;
          name = "catppuccin";
          style = "mocha";
        };
        comments.comment-nvim = {
          enable = true;
          mappings = {
            toggleCurrentLine = "<leader>/";
            toggleSelectedLine = "<leader>/";
          };
        };
        telescope.enable = true;
        notes.todo-comments = {
          enable = true;
        };
        tabline.nvimBufferline = {
          enable = true;
          mappings = {
            closeCurrent = "<leader>c";
            cycleNext = "L";
            cyclePrevious = "H";
          };
        };
        filetree.nvimTreeLua = {
          enable = true;
          view.width = 25;
          mappings = {
            toggle = "<leader>e";
          };
        };
        lsp = {
          trouble.enable = true;
          enable = true;
          formatOnSave = true;
          lightbulb.enable = true;
          lspSignature.enable = true;
        };
        languages = {
          ts = {
            enable = true;
            treesitter.enable = true;
            lsp.enable = true;
            format.enable = true;
            extraDiagnostics.enable = true;
          };
          rust = {
            enable = true;
            lsp.enable = true;
            treesitter.enable = true;
            crates.enable = true;
          };
          nix = {
            enable = true;
            treesitter.enable = true;
            lsp.enable = true;
            format.enable = true;
          };
        };
        autocomplete.enable = true;
        visuals = {
          enable = true;
          nvimWebDevicons.enable = true;
          cellularAutomaton = {
            enable = true;
            mappings.makeItRain = "<leader>bruh";
          };
        };
        treesitter = {
          enable = true;
          context.enable = true;
        };
        maps = {
          normal."<leader>m" = {
            silent = true;
            action = "<cmd>make<CR>";
            desc = "Run make";
          };
        };
        viAlias = false;
        terminal.toggleterm = {
          enable = true;
          mappings.open = "<leader>tv";
          direction = "vertical";
        };
        binds.whichKey.enable = true;
        utility.motion.leap.enable = true;
        assistant.copilot = {
          enable = true;
          mappings = {
            panel.open = "<M-p>";
            suggestion = {
              acceptWord = null;
              accept = "<M-j>";
              acceptLine = "<M-u>";
            };
          };
        };
      };
    };

    customNeovim = neovim-flake.lib.neovimConfiguration {
      modules = [configModule];
      inherit pkgs;
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
          inherit inputs customNeovim;
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
          inherit inputs customNeovim;
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
