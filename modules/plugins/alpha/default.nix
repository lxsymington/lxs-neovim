{ pkgs, dsl, ... }:
with dsl; {
  plugins = with pkgs; [
    alpha
  ];

  lua = ''
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")
    
    alpha.setup(dashboard.config)
  '';
}
