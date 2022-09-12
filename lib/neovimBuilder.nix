{ pkgs, config, ... }:
  let
    inherit (pkgs) lib neovim neovimPlugins wrapNeovim;
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

      packages.myVimPackage = with neovimPlugins; {
        start = vim.startPlugins;
        opt = vim.optPlugins;
      };
    };
  }
