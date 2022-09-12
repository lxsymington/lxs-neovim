{ config, lib, pkgs, ... }:
{
  imports = [
    ./core
    ./plugins/performance
    ./plugins/utilities
  ];
}
