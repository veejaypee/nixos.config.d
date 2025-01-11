{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./telescope.nix
  ];
  programs.nixvim.plugins = {
    which-key.enable = true;
    oil.enable = true;
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
        rust_analyzer = {
          enable = true;
          installRustc = false;
          cargoPackage = false;
          installCargo = false;
        };
        bashls.enable = true;
        ts_ls.enable = true;
        #angularls = {
        #  enable = true;
        #  package = null;
        #};
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
    web-devicons.enable = true;
  };
}
