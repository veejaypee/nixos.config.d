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
      tmuxPlugins.catppuccin
    ];

    extraConfig = ''
      set -g default-terminal "tmux-256color"
      set -ga terminal-overrides ",xterm-256color:Tc"
      set -ga terminal-overrides '*:Ss=\E[%p1%d q:Se=\E[ q'
      set-environment -g COLORTERM "truecolor"

      set -g @catppuccin_flavor 'mocha'
      set -g @catppuccin_window_status_style "rounded"
    '';
  };
}
