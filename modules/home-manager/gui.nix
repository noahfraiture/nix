{ pkgs, lib, config, ... }:

{
  home.packages = with pkgs; [
    opera
    spotify
    dolphin
    gparted
    onlyoffice-bin
    obsidian
    vlc
  ];
}
