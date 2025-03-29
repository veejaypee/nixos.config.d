{
  pkgs,
  config,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./tmux.nix
  ];
  home.shell.enableZshIntegration = true;
  programs = {
    alacritty.enable = true;

    zsh = {
      enable = true;
      defaultKeymap = "emacs";
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      history.size = 10000;
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
          success_symbol = "[](bold green) ";
          error_symbol = "[✗](bold red) ";
        };
      };
    };
  };
}
