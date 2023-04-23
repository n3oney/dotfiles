{
  programs.neovim-flake = {
    enable = true;
    settings = {
      vim = {
        presence.presence-nvim = {
          enable = true;
          auto_update = true;
          image_text = "The Superior Text Editor";
          client_id = "793271441293967371";
          main_image = "neovim";
          rich_presence = {
            editing_text = "Editing %s";
          };
        };
        git = {
          enable = true;
          gitsigns.enable = true;
        };
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
          lspsaga.enable = true;
          # trouble.enable = true;
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
  };
}
