{ pkgs, ... }:
{
  runtime = {
    "autoload/lxs/autocommands.lua" = {
      enable = true;
      source = ./autocommands.lua;
    };
  };
}
