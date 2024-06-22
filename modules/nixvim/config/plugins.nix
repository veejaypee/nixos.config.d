{
  pkgs,
  config,
  ...
}: {
  programs.nixvim.plugins = {
    which-key.enable = true;
    telescope = {
      enable = true;
    };

    oil.enable = true;

    bufferline = {
      enable = true;
    };
  };
}
