inputs: final: prev:
let
  withSrc = pkg: src: pkg.overrideAttrs (_: { inherit src; });
  plugin = pname: src: prev.vimUtils.buildVimPluginFrom2Nix {
    inherit pname src;
    version = "master";
  };
in
with inputs; {

  nil = inputs.nil.packages.${prev.system}.nil;

  # Packaging plugins with Nix
  # lsp-config = plugin "lsp-config" lsp-config-src;
}
