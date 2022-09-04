{
  description = "LXS Neovim Config";

  # Input source for our derivation
  inputs = {
    nixpkgs.url = "github:Nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    nix2vim = {
      url = "github:gytis-ivaskevicius/nix2vim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim = {
      url = "github:neovim/neovim?dir=contrib";
    };
    dotfiles = {
      url = "github:lxsymington/dotfiles";
      flake = false;
    };

    lsp-config = {
      url = "github:neovim/nvim-lspconfig";
      flake = false;
    };
    lsp-nil = {
      url = "github:oxalica/nil";
    };

    plugin-alpha-nvim = {
      url = "github:goolord/alpha-nvim";
      flake = false;
    };
    plugin-impatient-nvim = {
      url = "github:lewis6991/impatient.nvim";
      flake = false;
    };
    plugin-filetype-nvim = {
      url = "github:nathom/filetype.nvim";
      flake = false;
    };
    plugin-startuptime = {
      url = "github:dstein64/vim-startuptime";
      flake = false;
    };
    plugin-popup-nvim = {
      url = "github:nvim-lua/popup.nvim";
      flake = false;
    };
    plugin-plenary-nvim = {
      url = "github:nvim-lua/plenary.nvim";
      flake = false;
    };
    plugin-which-key-nvim = {
      url = "github:folke/which-key.nvim";
      flake = false;
    };
    plugin-lush-nvim = {
      url = "github:rktjmp/lush.nvim";
      flake = false;
    };
    plugin-shipwright-nvim = {
      url = "github:rktjmp/shipwright.nvim";
      flake = false;
    };
  };

  outputs = inputs@{ self, flake-utils, nixpkgs, neovim, nix2vim, lsp-nil, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            neovim.overlay
            (import ./plugins.nix inputs)
	    nix2vim.overlay
          ];
        };
        neovimConfig = pkgs.neovimBuilder {
          # Build with NodeJS
          withNodeJs = true;
          withPython3 = true;
          package = pkgs.neovim;
	  imports = [
	    ./modules/core
	    ./modules/plugins/alpha
	    ./modules/plugins/impatient
	    ./modules/plugins/which-key
	    ./modules/lsp/nil
	  ];
        };
      in
      {
        # The package built by `nix build .`
        defaultPackage = neovimConfig;
        # The app run by `nix run .`
        apps.defaultApp = {
          type = "app";
          program = "${neovimConfig}/bin/nvim";
        };
      });
}
