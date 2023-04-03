{
  config,
  pkgs,
  lib,
  vars,
  ...
}: {
  imports = [
    ./hyprland.nix
    ./wezterm.nix
    ./eww
  ];

  home.username = "neoney";
  home.homeDirectory = "/home/neoney";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;

  home.packages = with pkgs; [
    neofetch
    alejandra
    nixgl.nixGLIntel
    discord-canary

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  home.sessionVariables = {
    # EDITOR = "nvim";
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      format = ''
        ([\[](fg:8)$package$rust$username$hostname$cmd_duration$jobs[\]](fg:8))
        $directory([\[](fg:8)$git_branch$git_state$git_status$git_metrics[\]](fg:8))$fill$status$time
        $character
      '';
      scan_timeout = 10;
      add_newline = true;
      username = {
        show_always = false;
        format = "[$user@](fg:8)";
      };
      hostname = {
        ssh_only = true;
        format = "[$hostname](fg:8) ";
      };
      directory = {
        style = "bold blue";
        read_only = " ";
        truncate_to_repo = false;
        format = "[ $path]($style)[$read_only]($read_only_style) ";
        fish_style_pwd_dir_length = 1;
        truncation_length = 1;
        home_symbol = "~";
      };
      git_branch = {
        format = " [$symbol$branch]($style) ";
        symbol = "";
      };
      git_status = {
        format = "([$conflicted$deleted$renamed$modified$staged$untracked$ahead_behind]($style))";
        style = "bold cyan";
        up_to_date = "";
        conflicted = "=$count ";
        ahead = "⇡$count ";
        behind = "⇣$count ";
        diverged = "⇕$count ";
        untracked = "?$count ";
        stashed = "$$count ";
        modified = "!$count ";
        staged = "+$count ";
        renamed = "»$count ";
        deleted = "✘$count ";
      };
      git_metrics = {
        disabled = false;
        format = "([+$added]($added_style) )([-$deleted]($deleted_style) )";
      };
      jobs = {
        disabled = false;
        format = " bg jobs: [$symbol$number]($style) ";
        number_threshold = 1;
        symbol = "";
      };
      package = {
        format = "[$symbol$version]($style) ";
        symbol = " ";
      };
      cmd_duration = {
        min_time = 2000;
      };
      status = {
        disabled = false;
        format = "[(✖ $status $common_meaning )](bold red)";
      };
      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };
      fill = {
        symbol = " ";
      };
      time = {
        disabled = false;
      };
    };
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      if test -n "$DESKTOP_SESSION"
        source (gnome-keyring-daemon --start 2>/dev/null | sed -rn 's/^([^=]+)=(.*)/set -x \1 \2/p' | psub)
      end

      enable_transience
    '';
    functions = {
      nvim = ''
        if test $TERM = "alacritty"
            alacritty msg config window.opacity=1
          else
            printf "\033]1337;SetUserVar=%s=%s\007" nvim_open (echo -n yes | base64)
          end

          /usr/bin/env nvim $argv

          if test $TERM = "alacritty"
            alacritty msg config window.opacity=0.7
          else
            printf "\033]1337;SetUserVar=%s=%s\007" nvim_open (echo -n no | base64)
          end
      '';
      hd = ''
        home-manager switch --flake ~/.config/home-manager
      '';
    };
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

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
