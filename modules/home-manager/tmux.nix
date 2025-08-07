{
  pkgs,
  config,
  inputs,
  lib,
  ...
}: {
  programs.tmux = {
    enable = true;
    clock24 = true;
    baseIndex = 1;
    keyMode = "vi";

    plugins = with pkgs; [
    ];

    extraConfig = ''
      set -g default-terminal "tmux-256color"
      set -ag terminal-overrides ",xterm-256color:Tc"
    '';
  };
}
