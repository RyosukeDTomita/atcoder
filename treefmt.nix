{ pkgs, ... }:
{
  projectRootFile = "flake.nix";

  programs.mdformat.enable = true;
  programs.ormolu.enable = true;
  programs.ormolu.package = pkgs.haskell.packages.ghc96.ormolu;

  # treefmt controls mode/idempotence itself; pass only parser options.
  settings.formatter.ormolu.options = [
    "--ghc-opt"
    "-XImportQualifiedPost"
  ];
}
