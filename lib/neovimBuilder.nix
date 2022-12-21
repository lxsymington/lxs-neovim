{ pkgs, config, ... }:
  let
    inherit (pkgs) lib neovim wrapNeovim;
    inherit (lib) evalModules;
    inherit (vimOptions.config) vim;

    customNeovim = neovim;

    vimOptions = evalModules {
      modules = [
        { imports = [ ../modules]; }
        config
      ];

      specialArgs = {
        inherit pkgs;
      };
    };
   in wrapNeovim customNeovim {
    inherit (vim) viAlias vimAlias withNodeJs;
    configure = {
      customRC = vim.configRC;

      packages.myVimPackage = {
        start = builtins.filter (plugin: plugin != null) vim.startPlugins;
        opt = builtins.filter (plugin: plugin != null) vim.optPlugins;
      };
    };
  }
