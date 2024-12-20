{
  pkgs,
  config,
  inputs,
  lib,
  stylix,
  ...
}: {
  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    polarity = "dark";
    image = ../../../wallpaper.jpg;
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 32;
    };
    fonts = {
      monospace = {
        package = pkgs.fira-code;
        name = "FiraCode";
      };

      sizes = {
        applications = 16;
        desktop = 14;
        popups = 14;
        terminal = 18;
      };
    };
  };
}
