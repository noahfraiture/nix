{  pkgs, ... }:
{
  home.packages = with pkgs; [
    spotify
    opera
    dolphin
    gparted
    onlyoffice-bin
    obsidian
    vlc
  ];
}
