{ pkgs, dsl, ... }:
with dsl;
{
  vim.g = {
    mapleader = " ";
  };

  vim.o = {
    showcmd = true;
  };
}
