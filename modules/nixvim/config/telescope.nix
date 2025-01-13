{
  pkgs,
  config,
  ...
}: {
  programs.nixvim.plugins.telescope = {
    enable = true;
    extensions.fzf-native.enable = true;
    keymaps = {
      "<leader>ff" = {
        action = "find_files";
        options.desc = "Telescope find files";
      };
      "<leader><leader>" = {
        action = "buffers";
        options.desc = "Telescope buffers";
      };
    };
  };
}
