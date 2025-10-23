{
  pkgs,
  config,
  inputs,
  lib,
  hyprland,
  ...
}: {
  wayland.windowManager.hyprland.extraConfig = ''
    ${builtins.readFile ./hyprland.conf}
  '';
}
