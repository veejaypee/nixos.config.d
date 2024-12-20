{
  pkgs,
  config,
  ...
}: {
  programs.nixvim.plugins = {
    telescope = {
      enable = true;
      extenstions.fzf-native.enable = true;
    };
  };
}
