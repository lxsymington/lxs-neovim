{ pkgs, dsl, ... }:
with dsl; {
  plugins = with pkgs; [
    impatient
  ];

  lua = ''
    require("impatient");
  '';
}
