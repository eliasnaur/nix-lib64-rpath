{
  inputs = {
    nixpkgs.url = "nixpkgs";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          system = builtins.replaceStrings [ "darwin" ] [ "linux" ] system;
        };
      in {
        packages.default = pkgs.pkgsCross.raspberryPi.stdenv.mkDerivation {
          name = "demonstrate-lib64-rpath";
          src = ./.;

          buildPhase = ''
            echo "CC" $CC
            echo "NIX_LDFLAGS:" $NIX_LDFLAGS
          '';

          installPhase = ''
            mkdir $out
          '';
        };
      });
}
