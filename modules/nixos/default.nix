{ pkgs, ... }:

{
  imports = [ ];

  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    nushell
    hyprpanel
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    nerdfonts
  ];

  users.users.noah.packages = with pkgs; [
  ];
}
