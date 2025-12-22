{
  description = "Haskell dev environment AtCoder";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        formatter = nixpkgs.legacyPackages.${system}.nixfmt-tree;

        devShells.default = pkgs.mkShell {
          packages = [
            pkgs.zsh
            (pkgs.haskell.packages.ghc96.ghcWithPackages (ps: [
              ps.vector
              ps.containers
              ps.bytestring
            ]))
            pkgs.haskell.packages.ghc96.cabal-install
            pkgs.haskell.packages.ghc96.haskell-language-server
          ];
        };
      }
    );
}
