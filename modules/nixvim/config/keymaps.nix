{
  pkgs,
  config,
  ...
}: {
  programs.nixvim = {
    globals.mapleader = " ";
    globals.maplocalleader = " ";
  };
}
