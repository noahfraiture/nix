{
  pkgs,
  inputs,
  ...
}: {
  config = {
    nix.settings = {
      substituters = ["https://hyprland.cachix.org"];
      trusted-public-keys = [
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      ];
    };

    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      xwayland.enable = true;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };

    environment.sessionVariables = {
      # WLR_MO_HARDWARE_CURSOR = "1";
      NIXOS_OZONE_WL = "1";
    };

    xdg.portal = {
      enable = true;
      wlr.enable = true;
      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
      ];
    };

    services = {
      dbus.enable = true; # screen sharing
      displayManager.sddm.enable = true;
      xserver = {
        enable = true;
      };
      devmon.enable = true; # TODO : script wrapper for udisk2, need test
      udisks2.enable = true; # NOTE : daemon lib for mount/umount
      upower.enable = true; # NOTE : lib for power info
      power-profiles-daemon.enable = true; # TODO : choose the power manager
    };
  };
}
