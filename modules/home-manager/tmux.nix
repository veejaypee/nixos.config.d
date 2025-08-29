{
  pkgs,
  config,
  inputs,
  lib,
  ...
}: {
  programs.tmux = {
    enable = true;
    shortcut = "Space";
    clock24 = true;
    baseIndex = 1;
    keyMode = "vi";
    mouse = true;

    plugins = with pkgs; [
      tmuxPlugins.catppuccin
      tmuxPlugins.continuum
      tmuxPlugins.resurrect
      tmuxPlugins.vim-tmux-navigator
    ];

    extraConfig = ''
      set -g default-terminal "tmux-256color"
      set -ag terminal-overrides ",xterm-256color:Tc"

      set -g @catppuccin_flavor 'mocha'

      set -g escape-time 0
      set -g status-interval 3
      set -g set-clipboard on
      set -g detach-on-destroy off
      set -g history-limit 1000000
      set -g allow-passthrough on

      # Split horizontally in CWD with \
      unbind %
      bind \\ split-window -h -c "#{pane_current_path}"

      # Split vertically in CWD with -
      unbind \"
      bind - split-window -v -c "#{pane_current_path}"

      set -g renumber-windows on # Automatically renumber windows when one is closed

      set -g @resurrect-capture-pane-contents 'on'
    '';
  };
}
