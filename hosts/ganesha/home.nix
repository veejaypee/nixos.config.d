{
  pkgs,
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
  ];
  programs.nixvim = {
    enable = true;
    globals.mapleader = " ";
    globals.maplocalleader = " ";
    # import ../../modules/nixvim/config
    colorschemes.catppuccin = {
      enable = true;
      flavour = "mocha";
    };
    plugins = {
      cmp-snippy.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp-nvim-lsp-document-symbol.enable = true;
      cmp-nvim-lsp-signature-help.enable = true;
      cmp-buffer.enable = true;
      cmp-cmdline.enable = true;
      cmp-path.enable = true;
      cmp-treesitter.enable = true;
      cmp = {
        enable = true;

        autoEnableSources = true;
        settings = {
          snippet.expand = "snippy";
          sources = [
            {name = "snippy";}
            {name = "nvim_lsp";}
            {name = "nvim_lsp_document_symbol";}
            {name = "nvim_lsp_signature_help";}
            {name = "buffer";}
            {name = "cmdline";}
            {name = "path";}
            {name = "treesitter";}
          ];
          mapping = {
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = "cmp.mapping.select_next_item()";
            "<S-Tab>" = "cmp.mapping.select_prev_item()";
          };
        };
      };
      lsp = {
        enable = true;
        keymaps = {
          diagnostic = {
            "[d" = {
              action = "goto_next";
              desc = "Goto next diagnostic";
            };
            "]d" = {
              action = "goto_prev";
              desc = "Goto previous diagnostic";
            };
            "gl" = {
              action = "open_float";
              desc = "Open float";
            };
          };

          lspBuf = {
            K = {
              action = "hover";
              desc = "Hover";
            };
            gr = {
              action = "references";
              desc = "Goto references";
            };
            gd = {
              action = "definition";
              desc = "Goto definition";
            };
            gi = {
              action = "implementation";
              desc = "Goto implementation";
            };
            gt = {
              action = "type_definition";
              desc = "Type definition";
            };
            gs = {
              action = "signature_help";
              desc = "Signature help";
            };
            "<F2>" = {
              action = "rename";
              desc = "Rename variable";
            };
          };
        };
      };
      none-ls = {
        enable = true;
        enableLspFormat = true;
        sources.formatting.alejandra.enable = true;
      };
      lsp-format.enable = true;

      telescope = {
        enable = true;
      };

      oil.enable = true;

      # bufferline = {
      #   enable = true;
      # };
    };
  };
  # config = {
  #  # globals.have_nerd_font = true;
  #
  # options = {
  # ## prompt on exit instead of erroring when files are unvisited
  # cursorline = true;
  # confirm = true;
  # autochdir = true;
  #     };
  #     };
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "vjp";
  home.homeDirectory = "/home/vjp";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    discord
    vesktop

    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/vjp/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = false;
}
