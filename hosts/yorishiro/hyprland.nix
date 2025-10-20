{
  pkgs,
  config,
  inputs,
  lib,
  hyprland,
  ...
}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      splash_offset = 2.0;

      preload = ["./wallpaper.png"];

      wallpaper = [
        ",tile:./wallpaper.png"
      ];
    };
  };
  wayland.windowManager.hyprland.extraConfig = ''
    ${builtins.readFile ./hyprland.conf}
  '';
}
