{ pkgs, ... }:
{ config, system }:
  let
    inherit (pkgs.${system}) lib neovim-unwrapped neovimPlugins wrapNeovim;
    inherit (lib) evalModules;
    inherit (vimOptions.config) vim;
    
    customNeovim = neovim-unwrapped;
    
    vimOptions = evalModules {
      modules = [
        { imports = [ ../modules]; }
        config
      ];

      specialArgs = {
        inherit pkgs system;
      };
    };
  in wrapNeovim customNeovim {
    viAlias = vim.viAlias ? true;
    vimAlias = vim.vimAlias ? true;
    withNodeJs = vim.withNodeJs ? true;
    configure = {
      customRC = vim.configRC;

      packages.myVimPackage = with neovimPlugins; {
        start = vim.startPlugins;
        opt = vim.optPlugins;
      };
    };
  }
