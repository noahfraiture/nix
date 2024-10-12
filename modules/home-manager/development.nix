{ pkgs, lib, config, ... }:

{
  home.packages = with pkgs; [
    quickemu
    exegol
  ];
}
