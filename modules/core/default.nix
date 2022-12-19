{ config, lib, pkgs, ... }:
with lib;
with builtins;
let
  cfg = config.vim;

  wrapLuaConfig = luaConfig: ''
    lua << EOF
    ${luaConfig}
    EOF
  '';
in
{
  options.vim = {
    viAlias = mkOption {
      description = "Enable vi alias";
      type = types.bool;
      default = true;
    };

    vimAlias = mkOption {
      description = "Enable vim alias";
      type = types.bool;
      default = true;
    };
          
    withNodeJs = mkOption {
      description = "Include NodeJS and supporting package";
      type = types.bool;
      default = true;
    };
        
    configRC = mkOption {
      description = "$MYVIMRC contents";
      type = types.lines;
      default = "";
    };

    luaConfigRC = mkOption {
      description = "neovim lua config";
      type = types.lines;
      default = "";
    };

    startPlugins = mkOption {
      description = "List of plugins to startup";
      type = with types; listOf package;
      default = [];
    };

    optPlugins = mkOption {
      description = "List of plugins to startup";
      type = with types; listOf package;
      default = [];
    };
  };

  config = {
    vim.configRC = ''
      " Lua config from vim.luaConfigRC
      ${wrapLuaConfig cfg.luaConfigRC}
    '';
  };
}
