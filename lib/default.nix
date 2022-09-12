with builtins;
{
  neovimBuilder = import ./neovimBuilder.nix;
  pluginBuilder = import ./pluginBuilder.nix;

  mkPkgs = {flake-utils, nixpkgs, config ? {}, overlays ? []}:
    let
      inherit (flake-utils.lib) defaultSystems;
    in
      listToAttrs (map (system: {
        name = system; 
        value = (import nixpkgs { 
          inherit config system overlays;
        });
      }) defaultSystems);
}

