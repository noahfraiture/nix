{ pkgs }:

let
  image = pkgs.fetchurl {
    url = "https://gruvbox-wallpapers.pages.dev/wallpapers/anime/5m5kLI9.png";
    sha256 = "sha256-utmDMNeSzboGyup3+0N8hjk8/wgiFctuWYD4u/JptxE=";
  };
in
pkgs.stdenv.mkDerivation {
  name = "sddm-theme";
  src = pkgs.fetchFromGitHub {
    owner = "MarianArlt";
    repo = "sddm-sugar-dark";
    rev = "ceb2c455663429be03ba62d9f898c571650ef7fe";
    sha256 = "sha256-flOspjpYezPvGZ6b4R/Mr18N7N3JdytCSwwu6mf4owQ=";
  };
  installPhase = ''
    mkdir -p $out
    cp -R ./* $out/
    cd $out/
    rm Background.jpg
    cp -r ${image} $out/Background.jpg
   '';
}
