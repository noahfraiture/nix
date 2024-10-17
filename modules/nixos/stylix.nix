{ pkgs, ...}:
{
  stylix = {
    enable = true;
    image = ../../imgs/wallpaper.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";

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
