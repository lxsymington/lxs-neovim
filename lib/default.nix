{ pkgs, inputs, plugins, ... }:
{
  inherit (pkgs) lib;
  
  neovimBuilder = import ./neovimBuilder.nix { inherit pkgs; };

  mkPkgs = {flake-utils, nixpkgs, config ? {}, overlays ? []}:
    let
      inherit (flake-utils.lib) defaultSystems;
    in
    builtins.listToAttrs (map (system: {
      name = system; 
      value = (import nixpkgs { 
        inherit config system overlays;
      });
    }) defaultSystems);
}

