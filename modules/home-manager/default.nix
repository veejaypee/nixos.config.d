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
  programs = {
    alacritty.enable = true;

    zsh.enable = true;
    starship = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        add_newline = false;
        character = {
          success_symbol = "[](bold green) ";
          error_symbol = "[✗](bold red) ";
        };
      };
    };
  };
}
