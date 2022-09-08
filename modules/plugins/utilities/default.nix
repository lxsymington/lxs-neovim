{ pkgs, lib, config, ... }:
with lib;
with builtins;
{
  options.vim = {
    utilities = mkOption {
      default = true;
      description = "Enable utilities plugins";
      type = types.bool;
    };
  };

  config = {
    vim.startPlugins = with pkgs.neovimPlugins; [
      plugin-popup-nvim
      {
        plugin = plugin-plenary-nvim;
        type = "lua";
        runtime = {
          "autoload/lxs/autocommands.lua" = {
            enable = true;
            source = builtins.readfile ./autocommands.lua;
          };
        };
      }
    ];
  };
}
