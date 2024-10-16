{ pkgs, lib, config, ... }:

{
  home.packages = with pkgs; [
    exegol
    quickemu
    wakatime
  ];
}
