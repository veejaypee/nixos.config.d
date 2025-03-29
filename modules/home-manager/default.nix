{
  pkgs,
  config,
  inputs,
  lib,
  ...
}: {
  imports = [
    tmux.nix
  ];
  programs = {
    alacritty.enable = true;
    starship.enable = true;
  };
}
