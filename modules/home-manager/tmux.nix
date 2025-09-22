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
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.continuum
      tmuxPlugins.resurrect
    ];

    extraConfig = ''
      set -g default-terminal "tmux-256color"
      set -ag terminal-overrides ",xterm-256color:Tc"

      set -g @catppuccin_flavor 'mocha'

      set -g escape-time 0
      set -g status-interval 30
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

      # New window in same path
      bind c new-window -c "#{pane_current_path}"

      # Use vim arrow keys to resize
      bind -r j resize-pane -D 5
      bind -r k resize-pane -U 5
      bind -r l resize-pane -R 5
      bind -r h resize-pane -L 5

      # Start selecting text with "v"
      bind-key -T copy-mode-vi 'v' send -X begin-selection

      # Copy text with "y"
      bind -T copy-mode-vi 'y' send-keys -X copy-pipe-and-cancel "pbcopy"

      # Paste yanked text with "Prefix + P" ("Prefix + p" goes to previous window)
      bind P paste-buffer

      # Don't exit copy mode when dragging with mouse
      unbind -T copy-mode-vi MouseDragEnd1Pane

      set -g status-left-length 200   # default: 10
      set -g status-right-length 200  # default: 10
      set -g status-justify centre

      set -g renumber-windows on # Automatically renumber windows when one is closed

      set -g allow-rename off
      set -g automatic-rename on
      set-option -g automatic-rename-format '#{pane_current_command}'

      set -g @continuum-restore 'on'
      set -g @resurrect-capture-pane-contents 'on'
    '';
  };
}
