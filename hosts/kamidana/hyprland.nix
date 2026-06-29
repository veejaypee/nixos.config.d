{
  pkgs,
  config,
  inputs,
  lib,
  hyprland,
  ...
}: {
  wayland.windowManager.hyprland = {
    configType = "hyprlang";
    extraConfig = ''${builtins.readFile ./hyprland.conf}'';
}
