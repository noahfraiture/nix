{
  config,
  lib,
  pkgs,
  inputs,
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

    services = {
      displayManager = {
        sddm = lib.mkIf config.sddm.enable {
          enable = true;
          theme = "${import ./sddm-theme.nix { inherit pkgs; }}";
        };
      };
      greetd = lib.mkIf config.greetd.enable {
        enable = true;
        settings = rec {
          initial_session = {
            command = "Hyprland";
            user = "noah";
          };
          default_session = initial_session;
        };
      };
    };

    users.defaultUserShell = pkgs.nushell;

    # TODO : move swww
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
            pkgs.libsForQt5.qt5.qtgraphicaleffects
            inputs.swww.packages.${pkgs.system}.swww
          ]
        else
          [ ]
      );

  };

  options = {
    sddm.enable = lib.mkEnableOption "enable ssdm";
    greetd.enable = lib.mkEnableOption "enable greetd";
    fonts.enable = lib.mkEnableOption "pkgs fonts";
    graphical.enable = lib.mkEnableOption "graphical stuffs";
  };
}
