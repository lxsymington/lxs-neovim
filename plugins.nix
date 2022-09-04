inputs: final: prev:
let
  withSrc = pkg: src: pkg.overrideAttrs (_: { inherit src; });
  plugin = pname: src: prev.vimUtils.buildVimPluginFrom2Nix {
    inherit pname src;
    version = "master";
  };
in
with inputs; {
  nil = inputs.lsp-nil.packages.${prev.system}.nil;

  # Packaging plugins with Nix
  alpha = plugin "alpha" plugin-alpha-nvim;
  impatient = plugin "impatient" plugin-impatient-nvim;
  filetype = plugin "filetype" plugin-filetype-nvim;
  startuptime = plugin "startuptime" plugin-startuptime;
  popup = plugin "popup" plugin-popup-nvim;
  plenary = plugin "plenary" plugin-plenary-nvim;
  which-key = plugin "which-key" plugin-which-key-nvim;
  lsp-config = plugin "lsp-config" lsp-config;
}
