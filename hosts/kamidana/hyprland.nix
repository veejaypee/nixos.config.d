{
  pkgs,
  config,
  inputs,
  lib,
  hyprland,
  ...
}: {
  wayland.windowManager.hyprland = {
    configType = "lua";
    extraConfig = ''${builtins.readFile ./hyprland.lua}'';
}
