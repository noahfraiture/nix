{ pkgs, config, ... }:
{
  home.packages = with pkgs; [
    rofi-wayland-unwrapped
  ];

  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;

    theme = {
      "*" = {
        main-bg = "#${config.lib.stylix.colors.base00}";
        main-fg = "#${config.lib.stylix.colors.base05}";
        main-br = "#${config.lib.stylix.colors.base06}";
        main-ex = "#${config.lib.stylix.colors.base07}";
        select-bg = "#${config.lib.stylix.colors.base05}";
        select-fg = "#${config.lib.stylix.colors.base00}";
        separatorcolor = "transparent";
        border-color = "transparent";
      };
    };
  };
}
