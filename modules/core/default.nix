{ config, lib, pkgs, ... }:
with lib;
with builtins;
let
  # Looks as if this may be the wrong format, see https://github.com/NixOS/nixpkgs/blob/5f326e2a403e1cebaec378e72ceaf5725983376d/pkgs/applications/editors/neovim/utils.nix#L34
  pluginWithConfigType = types.submodule {
    options = {
      config = mkOption {
        type = types.lines;
        description =
          "Script to configure this plugin. The scripting language should match type.";
        default = "";
      };

      type = mkOption {
        type =
          types.either (types.enum [ "lua" "viml" "teal" "fennel" ]) types.str;
        description =
          "Language used in config. Configurations are aggregated per-language.";
        default = "viml";
      };

      optional = mkEnableOption "optional" // {
        description = "Don't load by default (load with :packadd)";
      };

      plugin = mkOption {
        type = types.package;
        description = "vim plugin";
      };

      runtime = mkOption {
        default = { };
        # passing actual "${xdg.configHome}/nvim" as basePath was a bit tricky
        # due to how fileType.target is implemented
        type = fileType "<varname>xdg.configHome/nvim</varname>" "nvim";
        example = literalExpression ''
          { "ftplugin/c.vim".text = "setlocal omnifunc=v:lua.vim.lsp.omnifunc"; }
        '';
        description = lib.mdDoc ''
          Set of files that have to be linked in nvim config folder.
        '';
      };
    };
  };
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

    startPlugins = mkOption {
      description = "List of plugins to startup";
      type = with types; listOf (either package pluginWithConfigType);
      default = [];
    };

    optPlugins = mkOption {
      description = "List of plugins to startup";
      type = with types; listOf (either package pluginWithConfigType);
      default = [];
    };
  };
}