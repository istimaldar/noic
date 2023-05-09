{ pkgs, ... }: pkgs.stdenv.mkDerivation {
  name = "install.sh";
  phases = [ "installPhase" ];
  src = ./../..;
  installPhase = "mkdir -p $out/bin; ls $src; install -t $out/bin $src/install.sh";
}