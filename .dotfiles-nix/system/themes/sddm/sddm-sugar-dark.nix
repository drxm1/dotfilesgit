{ pkgs }:
let
  imgLink =
    "https://raw.githubusercontent.com/dominikrosser/dotfilesgit/main/Pictures/WallpapersForHyprland/Desktop3.jpg";
  image = pkgs.fetchurl {
    url = imgLink;
    sha256 = "07qhgdly0hyvy9v9c1gacakrlwwpnfd4q65x624ssrs7wdch3s5f";
  };
in pkgs.stdenv.mkDerivation {
  name = "sddm-theme-sugar-dark";
  src = pkgs.fetchFromGitHub {
    owner = "MarianArlt";
    repo = "sddm-sugar-dark";
    rev = "ceb2c455663429be03ba62d9f898c571650ef7fe";
    sha256 = "0153z1kylbhc9d12nxy9vpn0spxgrhgy36wy37pk6ysq7akaqlvy";
  };
  installPhase = ''
    mkdir -p $out
    cp -R ./* $out/
    cd $out/
    rm Background.jpg
    cp -r ${image} $out/Background.jpg
  ''; # lol this works even if it is a png...
}
