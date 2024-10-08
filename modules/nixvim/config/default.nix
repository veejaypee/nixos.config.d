{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./keymaps.nix
    ./plugins.nix
  ];
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    opts = {
      number = true;
      relativenumber = true;
    };
    colorschemes.catppuccin = {
      enable = true;
      settings.flavour = "mocha";
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
          snippet.expand = "function(args) require('snippy').expand_snippet(args.body) end";
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
        servers = {
          rust-analyzer = {
            enable = true;
            installRustc = false;
            cargoPackage = false;
            installCargo = false;
          };
          bashls.enable = true;
        };

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
            "<leader>carn" = {
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
      lsp-lines.enable = true;
      lsp-status.enable = true;
      lspkind = {
        enable = true;
        cmp.enable = true;
      };
      lint.enable = true;
      nix.enable = true;
      nvim-autopairs.enable = true;
      treesitter.enable = true;
      rainbow-delimiters.enable = true;
    };
  };
}
