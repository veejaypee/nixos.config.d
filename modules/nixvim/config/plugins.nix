{
  pkgs,
  config,
  ...
}: {
  programs.nixvim.plugins = {
    which-key.enable = true;
    oil.enable = true;
  };
}
