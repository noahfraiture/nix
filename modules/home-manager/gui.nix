{  pkgs, ... }:
{
  home.packages = with pkgs; [
    bruno
    gparted
    obsidian
    onlyoffice-bin
    opera
    qbittorrent
    spotify
    vlc
    vscode
    zed-editor
  ];
}
