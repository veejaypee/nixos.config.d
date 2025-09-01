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
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 16;
    };
    fonts = {
      monospace = {
        package = pkgs.fira-code;
        name = "FiraCode";
      };

      sizes = {
        applications = 10;
        desktop = 10;
        popups = 10;
        terminal = 12;
      };
    };
    targets = {
     # chromium.enable = false;
    };
  };
}
