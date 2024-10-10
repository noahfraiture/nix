{ pkgs, lib, config, ... }:

{
  imports = [
    ./hyprland.nix
  ];

  home.packages = with pkgs; [
    waybar
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
