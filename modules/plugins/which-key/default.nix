{ pkgs, dsl, ... }:
with dsl; {
  plugins = with pkgs; [
    which-key
  ];

  use.which-key.setup = callWith {
    plugins = {
      spelling = {
        enabled = true;
        suggestions = 20;
      };
    };
    window = {
      winblend = 10;
    };
  };
}
