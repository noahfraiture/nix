{ pkgs, lib, config, ... }:

{
  imports = [
    ./hyprland.nix
    ./waybar.nix
  ];

  home.packages = with pkgs; [
    eww
    dunst
    libnotify
    rofi-wayland
    swww
  ];

  # xdg.portal.enable = true;
  # xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  # xdg.portal.config.common.default = "gtk";
}
