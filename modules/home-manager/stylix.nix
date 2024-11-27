{
  config,
  pkgs,
  lib,
  ...
}:
{

  options = {
    theme.option = lib.mkOption {
      type = lib.types.str;
      default = "dark";
    };
  };

  config = {
    stylix = {
      enable = true;

      image = pkgs.fetchurl {
        url = "https://gruvbox-wallpapers.pages.dev/wallpapers/anime/classroom.jpg";
        sha256 = "sha256-jzok9VIwySb+ek2soMMxXcoVUTZh8UGLqloM/npQtAo=";
      };

      # https://github.com/tinted-theming/schemes
      base16Scheme =
        if config.theme.option == "dark" then
          "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml"
        else if config.theme.option == "light" then
          "${pkgs.base16-schemes}/share/themes/catppuccin-latte.yaml"
        else
          throw "wrong theme : " + config.theme.option;

      polarity = config.theme.option;

      # https://github.com/ful1e5/Bibata_Cursor
      cursor = {
        package = pkgs.bibata-cursors;
        name =
          if config.theme.option == "dark" then
            "Bibata-Modern-Ice"
          else if config.theme.option == "light" then
            "Bibata-Modern-Classic"
          else
            throw "wrong theme : " + config.theme;
        size = 24;
      };

      fonts = {
        monospace = {
          package = pkgs.nerdfonts;
          name = "JetBrainsMono Nerd Font Propo";
        };
        sizes = {
          desktop = 16;
        };
      };
    };
  };
}
