{ pkgs, dsl, ... }:
with dsl; {
  plugins = with pkgs; [
    lsp-config
  ];

  use.lspconfig.rnix.setup = callWith {
    autostart = true;
    cmd = [ "${pkgs.nil}/bin/nil" ];
  };
}
