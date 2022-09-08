{ pkgs, lib, config, ... }:
with lib;
with builtins;
{
  options.vim = {
    performance = mkOption {
      default = true;
      description = "Enable performance plugins";
      type = types.bool;
    };
  };

  config = {
    vim.startPlugins = with pkgs.neovimPlugins; [
      {
        plugin = plugin-impatient-nvim;
        type = "lua";
        runtime = {
          "autoload/lxs/performance.lua" = {
            enable = true;
            text = ''
              require("impatient");
            '';
          };
        };
      }
      plugin-filetype-nvim
      plugin-startuptime
    ];
  };
}
