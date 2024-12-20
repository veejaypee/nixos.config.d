{
  pkgs,
  config,
  inputs,
  lib,
  ...
}: {
  programs.alacritty = {
    enable = true;
  };
}
