{ pkgs, ...}:
{
  stylix = {
    enable = true;
    image = ../../imgs/wallpaper.jpg;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-medium.yaml";
  };
}
