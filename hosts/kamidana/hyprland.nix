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
    extraLuaFiles = {
      "main" = {
        content = ./main.lua
        autoLoad = true;
      };
    };
  };
}
