{ pkgs, ... }:
{

  specialisation = {
    dark.configuration = {
      stylix = {
        # https://github.com/tinted-theming/schemes
        base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
        polarity = "dark";
        # https://github.com/ful1e5/Bibata_Cursor
        cursor = {
          package = pkgs.bibata-cursors;
          name = "Bibata-Modern-Ice";
          size = 24;
        };
      };
    };
    light.configuration = {
      stylix = {
        # https://github.com/tinted-theming/schemes
        base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-latte.yaml";
        polarity = "dark";
        # https://github.com/ful1e5/Bibata_Cursor
        cursor = {
          package = pkgs.bibata-cursors;
          name = "Bibata-Modern-Classic";
          size = 24;
        };
      };
    };
  };

  stylix = {
    enable = true;

    image = pkgs.fetchurl {
      url = "https://gruvbox-wallpapers.pages.dev/wallpapers/anime/classroom.jpg";
      sha256 = "sha256-jzok9VIwySb+ek2soMMxXcoVUTZh8UGLqloM/npQtAo=";
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
}
