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
          success_symbol = "[>](bright-blue bold)";
          error_symbol = "[x](bright-red bold)";
        };
      };
    };
  };
}
