with builtins;
rec {
  evalMods = {finalPkgs, system, modules, args ?{}}: let
    pkgs = finalPkgs."${system}";
  in pkgs.lib.evalModules {
    inherit modules;
    specialArgs = { inherit pkgs; } // args;
  };

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

  neovimBuilder = {pkgs, config, ...}: let
    inherit (vimOptions.config) vim;
    inherit (pkgs) neovimPlugins;

    vimOptions = pkgs.lib.evalModules {
      modules = [
        { imports = [ ../modules]; }
        config
      ];

      specialArgs = {
        inherit pkgs;
      };
    };
  in pkgs.wrapNeovim pkgs.neovim-nightly {
    defaultEditor = true;
    viAlias = vim.viAlias ? true;
    vimAlias = vim.vimAlias ? true;
    withNodeJs = vim.withNodeJs ? true;
    configure = {
      customRC = vim.configRC;

      packages.myVimPackage = with pkgs.vimPlugins; {
        start = vim.startPlugins;
        opt = vim.optPlugins;
      };
    };
    runtime = {} // vim.runtime;
  };
}
