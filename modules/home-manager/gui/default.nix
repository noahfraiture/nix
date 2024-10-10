{ pkgs, lib, config, ... }:

{
  programs.kitty = {
    enable = true;
  };

  home.packages = with pkgs; [
    opera
    spotify
    dolphin
  ];
}
