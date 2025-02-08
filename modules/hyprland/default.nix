{
  pkgs,
  config,
  inputs,
  lib,
  hyprland,
  ...
}: {
  hyprland = {
    enable = true;
    xwayland.enable = true;
  };
}
