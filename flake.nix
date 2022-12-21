{
  description = "LXS Neovim Config";

  # Input source for our derivation
  inputs = {
    nixpkgs.url = "github:Nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    neovim = {
      url = "github:neovim/neovim?dir=contrib";
    };

    lsp-config = {
      url = "github:neovim/nvim-lspconfig";
      flake = false;
    };
    lsp-nil = {
      url = "github:oxalica/nil";
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
  };

  outputs = { self, nixpkgs, flake-utils, neovim, lsp-nil, ... }@inputs:
    let
      lib = import ./lib;

      plugins = [
        "plugin-impatient-nvim"
        "plugin-filetype-nvim"
        "plugin-startuptime"
        "plugin-popup-nvim"
        "plugin-plenary-nvim"
      ];

      neovimBuilder = lib.neovimBuilder;
      pluginOverlays = lib.pluginBuilder { inherit inputs plugins; };
      externalDependencyOverlays = final: prev: {
        rnix-lsp = lsp-nil.packages.${final.system}.default;
      };

      pkgs = lib.mkPkgs {
        inherit flake-utils nixpkgs;
        overlays = [
          neovim.overlay
          externalDependencyOverlays
          pluginOverlays
        ];
      };
    in flake-utils.lib.eachDefaultSystem (system:
      rec {
        packages = rec {
          lxs-neovim = neovimBuilder {
            pkgs = pkgs.${system};
            config = {};
          };
          # The package built by `nix build .`
          default = lxs-neovim;
        };

        overlays = {
          default = final: prev: {
            inherit neovimBuilder;
            neovimPlugins = pkgs.neovimPlugins;
          };
        };

        devShells = {
          default = pkgs.mkShell {
            buildInputs = [packages.lxs-neovim];
          };
        };

        nixosModules = {
          hm = {
            imports = [
              ./lib/hm.nix
              { nixpkgs.overlays = [ overlays.default ]; }
            ];
          };
        };

        # The app run by `nix run .`
        apps = rec {
          nvim = flake-utils.lib.mkApp {
            name = "nvim";
            drv = packages.lxs-neovim;
          };
          default = nvim;
        };
      });
}
