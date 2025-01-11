{
  pkgs,
  config,
  ...
}: {
  programs.nixvim.plugins.telescope = {
    enable = true;
    extensions.fzf-native.enable = true;
  };
  programs.nixvim.keymaps = [
    {
      action = "require('telescope.builtin').find_files";
      key = "<space>ff";
      mode = ["n"];
      desc = "Fuzzy find files";
    }
  ];
}
