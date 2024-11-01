{
  config,
  lib,
  pkgs,
  ...
}:

{
  config = {
    fonts.packages =
      with pkgs;
      lib.mkIf config.fonts.enable [
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-emoji
        nerdfonts
      ];

    services = lib.mkIf config.sddm.enable {
      displayManager.sddm = {
        enable = true;
        theme = "${import ./sddm-theme.nix { inherit pkgs; }}";
      };
    };

    users.defaultUserShell = pkgs.nushell;

    environment.systemPackages =
      with pkgs;
      [
        vim
        git
        wget
        nushell
      ]
      ++ (
        if config.graphical.enable then
          [
            pkgs.libsForQt5.qt5.qtgraphicaleffects # required for sugar candy
          ]
        else
          [ ]
      );

  };

  options = {
    sddm.enable = lib.mkEnableOption "enable ssdm";
    fonts.enable = lib.mkEnableOption "pkgs fonts";
    graphical.enable = lib.mkEnableOption "graphical stuffs";
  };
}
