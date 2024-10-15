{ pkgs, lib, config, ... }:

{
  programs.kitty = {
    enable = true;
  };

  home.packages = with pkgs; [
    kitty
  ];
}
