{ config, pkgs, lib ? pkgs.lib, ... }:

let
  cfg = config.programs.lxs-neovim;
  custom-neovim = pkgs.neovimBuilder { config = cfg.settings; };
in
with lib; {
  meta.maintainers = [ maintainers.lxsymington ];

  options.programs.lxs-neovim = {
    enable = mkEnableOption "Personal neovim configuration";

    settings = mkOption {
      type = types.attrsOf types.anything;
      default = { };
      example = literalExpression ''
        {
          vim.viAlias = false;
          vim.vimAlias = true;
        }
      '';
      description = "Exposed configuration options";
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ custom-neovim ];
  };
}
