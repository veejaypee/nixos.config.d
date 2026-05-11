{
  pkgs,
  config,
  inputs,
  lib,
  hyprland,
  ...
}: {
  programs.hyprland = {
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };
  environment.systemPackages = with pkgs; [
    hyprlock
    hyprpicker
    hypridle
    # hyprsysteminfo
    hyprpolkitagent
    hyprsunset
    hyprshot
    hyprpaper
  ];
}
