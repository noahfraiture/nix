{ pkgs, ... }:
{
  stylix = {
    enable = true;

    image = pkgs.fetchurl {
      url = "https://gruvbox-wallpapers.pages.dev/wallpapers/anime/classroom.jpg";
      sha256 = "sha256-jzok9VIwySb+ek2soMMxXcoVUTZh8UGLqloM/npQtAo=";
    };
    # https://github.com/tinted-theming/schemes
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";

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
