{ ... }:
{
  projectRootFile = "flake.nix";

  programs.mdformat.enable = true;
  programs.ormolu.enable = true;

  # treefmt controls mode/idempotence itself; pass only parser options.
  settings.formatter.ormolu.options = [
    "--ghc-opt"
    "-XImportQualifiedPost"
  ];
}
