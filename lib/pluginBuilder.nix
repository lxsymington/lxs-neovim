{ inputs, plugins, ... }:
final: prev:
with builtins;
  let
    buildPlugin = name: final.vimUtils.buildVimPluginFrom2Nix {
      pname = name;
      version = "master";
      src = getAttr name inputs;
    };
  in {
    neovimPlugins = listToAttrs (map (name: {
      inherit name;
      value = buildPlugin name;
    }) plugins);
  }
