{ pkgs }:

pkgs.stdenv.mkDerivation {
  name = "gruvbox-plus";
  src = pkgs.fetchurl {
    url = "https://github.com/SylEleuth/gruvbox-plus-icon-pack/releases/download/v5.2/gruvbox-plus-icon-pack-5.2.zip";
    sha256 = "15qhpg45wyzsqq228fvnyby3386kffbzlhx37q0g1p4bdb64wsd3";
  };
  dontUnpack = true;
  installPhase = ''
    mkdir -p $out
    ${pkgs.unzip}/bin/unzip $src -d $out/
    '';
}
