{ pkgs, lib, config, ... }:
with lib;
with builtins;

let
  cfg = config.vim;
in {
  options.vim = {
    manpager = mkOption {
      description = "Include neovim manpager settings";
      type = types.bool;
      default = true;
    };
    matchit = mkOption {
      description = "Include neovim enhanced matching plugin";
      type = types.bool;
      default = true;
    };
  };

  config = let
    writeIf = cond: config: if cond then config else "";
  in {
    vim.luaConfigRC = ''
      ${writeIf cfg.manpager ''
        vim.cmd.runtime("ftplugin/man.vim")
      ''}

      ${writeIf cfg.matchit ''
        vim.cmd.runtime("macros/matchit.vim")
      ''}
    '';
  };
}
