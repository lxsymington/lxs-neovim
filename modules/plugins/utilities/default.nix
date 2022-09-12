{ pkgs, lib, config, ... }:
with lib;
with builtins;
let
  cfg = config.vim.utilities;
in
{
  options.vim.utilities = {
    enable = mkEnableOption {
      default = true;
      description = "Enable utilities plugins";
      type = types.bool;
    };
  };

  config = mkIf cfg.enable {
    vim.startPlugins = with pkgs.neovimPlugins; [
      plugin-popup-nvim
      {
        plugin = plugin-plenary-nvim;
        type = "lua";
        runtime = {
          "autoload/lxs/autocommands.lua" = {
            enable = true;
            type = "lua";
            source = readFile ./autocommands.lua;
          };
          "autoload/lxs/commands.lua" = {
            enable = true;
            type = "lua";
            source = readFile ./commands.lua;
          };
        };
      }
    ];
  };
}
