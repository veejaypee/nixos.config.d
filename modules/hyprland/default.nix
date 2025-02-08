{
  pkgs,
  config,
  inputs,
  lib,
  hyprland,
  ...
}: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}
