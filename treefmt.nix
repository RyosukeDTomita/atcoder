{ ... }:
{
  projectRootFile = "flake.nix";

  programs.mdformat.enable = true;
  programs.ormolu.enable = true;
}
