{
  description = "LXS Neovim Config";

  # Input source for our derivation
  inputs = {
    nixpkgs.url = "github:Nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    neovim = {
      url = "github:neovim/neovim?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
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

  outputs = { self, flake-utils, nixpkgs, neovim, lsp-nil, ... }@inputs:
    let
      externalDependencyOverlays = final: prev: {
        rnix-lsp = lsp-nil.packages.${final.system}.default;
      };
      
      plugins = [
        "plugin-alpha-nvim"
        "plugin-impatient-nvim"
        "plugin-filetype-nvim"
        "plugin-startuptime"
        "plugin-popup-nvim"
        "plugin-plenary-nvim"
        "plugin-which-key-nvim"
        "plugin-lush-nvim"
        "plugin-shipwright-nvim"
      ];

      pkgs = lib.mkPkgs {
        inherit flake-utils nixpkgs;
        overlays = [
          neovim.overlay
          externalDependencyOverlays
          pluginOverlays
        ];
      };

     pluginOverlays = final: prev:
        let
          buildPlugin = name: final.vimUtils.buildVimPluginFrom2Nix {
            pname = name;
            version = "master";
            src = builtins.getAttr name inputs;
          };
        in {
          neovimPlugins = builtins.listToAttrs (map (name: {
            inherit name;
            value = buildPlugin name;
          }) plugins);
        };

      lib = import ./lib {
        inherit pkgs inputs plugins;
      };

      inherit (lib) neovimBuilder;
    in flake-utils.lib.eachDefaultSystem (system:
      {
        packages = rec {
          lxs-neovim = neovimBuilder {
            inherit system;
            config = {};
          };
          # The package built by `nix build .`
          default = lxs-neovim;
        };
        # The app run by `nix run .`
        apps = rec {
          nvim = {
            type = "app";
            program = "${self.packages."${system}".default}/bin/nvim";
          };
          defaultApp = nvim;
        };
      });
}
