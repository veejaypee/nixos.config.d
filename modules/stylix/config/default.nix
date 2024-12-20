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
        applications = 12;
        desktop = 12;
        popups = 12;
        terminal = 18;
      };
    };
  };
}
