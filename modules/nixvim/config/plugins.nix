{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./telescope.nix
  ];
  programs.nixvim.plugins = {
    which-key.enable = true;
    oil.enable = true;
  };
}
