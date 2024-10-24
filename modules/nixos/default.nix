{ pkgs, ... }:

{
  imports = [ ];

  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    nushell
    hyprpanel
    libsForQt5.qt5.qtgraphicaleffects # required for sugar candy

  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    nerdfonts
  ];

  users.users.noah.packages =
    [
    ];

  services = {
    displayManager.sddm = {
      enable = true;
      theme = "${import ./sddm-theme.nix { inherit pkgs; }}";
    };
  };
}
