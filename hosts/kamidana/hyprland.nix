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
#    extraLuaFiles = {
#     "main.lua" = {
#       content = ./main.lua;
#       autoLoad = true;
#     };
#   };
  };
}
