{
  description = "LXS Neovim Config";

  # Input source for our derivation
  inputs = {
    nixpkgs.url = "github:Nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    cornelis.url = "github:isovector/cornelis";

    nix2vim = {
      url = "github:gytis-ivaskevicius/nix2vim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim = {
      url = "github:neovim/neovim?dir=contrib";
    };
  };

  outputs = inputs@{ self, flake-utils, nixpkgs, neovim, nix2vim, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            neovim.overlay
            # (import ./plugins.nix inputs)
            nix2vim.overlay
          ];
        };
        neovimConfig = pkgs.neovimBuilder {
          # Build with NodeJS
          withNodeJs = true;
          withPython3 = true;
          package = pkgs.neovim;
          imports = [
            # ./modules/essentials.nix
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
