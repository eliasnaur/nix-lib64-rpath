{
  inputs = {
    nixpkgs.url = "nixpkgs";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
        };
      in {
        packages.default = pkgs.pkgsCross.raspberryPi.pkgsMusl.stdenv.mkDerivation {
          name = "demonstrate-lib64-rpath";
          src = ./.;

          buildPhase = ''
            echo "CC" $CC
            echo "NIX_COREFOUNDATION_RPATH": $NIX_COREFOUNDATION_RPATH
            echo "NIX_LDFLAGS:" $NIX_LDFLAGS
          '';

          installPhase = ''
            mkdir $out
          '';
        };
      });
}
