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
in {
  options = {
    vim = {
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
        description = "Enable node js plugins and tools";
        type = types.bool;
        default = true;
      };

      configRC = mkOption {
        description = "vimrc contents";
        type = types.lines;
        default = "";
      };

      luaConfigRC = mkOption {
        description = "vim lua config";
        type = types.lines;
        default = "";
      };

      startPlugins = mkOption {
        description = "List of plugins to be loaded at startup";
        default = [ ];
        type = with types; listOf (nullOr package);
      };

      optPlugins = mkOption {
        description = "List of plugins to be optionally loaded";
        default = [ ];
        type = with types; listOf (nullOr package);
      };
    };
  };

  config = {
    vim.configRC = ''
      " Lua config from vim.luaConfigRC
      ${wrapLuaConfig cfg.luaConfigRC}
    '';
  };
}
