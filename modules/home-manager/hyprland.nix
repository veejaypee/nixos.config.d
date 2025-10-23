{
  pkgs,
  config,
  inputs,
  lib,
  hyprland,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    plugins = [
      # inputs.hyprhook.packages.${pkgs.stdenv.hostPlatform.system}.hyprhook
    ];
  };
  services = {
    hyprpaper = {
      enable = true;
      settings = {
        ipc = "on";
        splash = false;
        splash_offset = 2.0;
        preload = [
          "../../hosts/yorishiro/wallpaper.png"
        ];
        wallpaper = [
          ",../../hosts/yorishiro/wallpaper.png"
        ];
      };
    };
  };
  programs.eww = {
    enable = true;
    configDir = ./eww;
  };
}
