{
  pkgs,
  config,
  ...
}: {
  programs.nixvim = {
    globals.mapleader = " ";
  };
}
