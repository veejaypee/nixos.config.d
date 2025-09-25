{
  pkgs,
  config,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./tmux.nix
    ./hyprland.nix
    ./waybar.nix
  ];
  home.shell.enableZshIntegration = true;
  programs = {
    alacritty = {
      enable = true;
      settings = {
        env.TERM = "alacritty-direct";
      };
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "fd --type f";
      colors = {
        "bg+" = "#313244";
        "bg" = "#1E1E2E";
        "spinner" = "#F5E0DC";
        "hl" = "#F38BA8";
        "fg" = "#CDD6F4";
        "headr" = "#F38BA8";
        "info" = "#CBA6F7";
        "pointr" = "#F5E0DC";
        "marker" = "#B4BEFE";
        "fg+" = "#CDD6F4";
        "prompt" = "#CBA6F7";
        "hl+" = "#F38BA8";
        "selected-g" = "#45475A";
        "border" = "#6C7086";
        "label" = "#CDD6F4";
      };
    };

    zsh = {
      enable = true;
      defaultKeymap = "emacs";
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      history = {
        size = 10000;
        append = true;
        expireDuplicatesFirst = true;
      };
      initContent = ''
        bindkey "^[[3~" delete-char
      '';
    };

    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        add_newline = false;
        directory = {
          truncation_symbol = ".../";
          truncate_to_repo = false;
        };
        character = {
          success_symbol = "[](bold green)";
          error_symbol = "[✗](bold red)";
        };
      };
    };
  };
}
