{
  lib,
  config,
  inputs,
  pkgs,
  ...
}:
{
  imports = [ inputs.ags.homeManagerModules.default ];

  home.packages = with pkgs; [
    bun
    translate-shell
    papirus-icon-theme
    brightnessctl
    sassc
  ];

  programs.ags = {
    enable = true;

    configDir = ./ags;

    extraPackages = with pkgs; [
      gtksourceview
      webkitgtk
      accountsservice
    ];
  };

  gtk.iconTheme = {
    name = "Papirus";
    package = pkgs.papirus-icon-theme;
  };

  home.activation = {
    cleanAgs = lib.hm.dag.entryAfter [
      "writeBoundary"
    ] ''run rm -rf ${config.home.homeDirectory}/.cache/ags'';
  };
}
