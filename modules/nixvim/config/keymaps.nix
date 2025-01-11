{
  pkgs,
  config,
  ...
}: {
  programs.nixvim = {
    globals.mapleader = " ";

    keymaps = [
      {
        action = "<cmd>Oil<CR>";
        key = "-";
        mode = ["n"];
      }
    ];

    plugins = {
      lsp.keymaps = {
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
  };
}
