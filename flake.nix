{
  description = "Haskell dev environment AtCoder";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        hsPkgs = pkgs.haskell.packages.ghc945;
      in {
        devShells.default = pkgs.mkShell {
          packages = [
            hsPkgs.ghc
            hsPkgs.cabal-install
            hsPkgs.haskell-language-server

            # よく使う外部パッケージ
            hsPkgs.vector
          ];
        };
      }
    );
}
