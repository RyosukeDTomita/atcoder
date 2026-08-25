{ pkgs, ... }:
{
  projectRootFile = "flake.nix";

  # mdformat 本体は thematic break を変換するため、`---` のまま出力する
  # mdformat-simple-breaks プラグインを使う。programs.mdformat は package
  # 上書きを尊重しないため settings.formatter で直接指定する。
  settings.formatter.mdformat = {
    command = "${pkgs.mdformat.withPlugins (ps: with ps; [ ps.mdformat-simple-breaks ])}/bin/mdformat";
    includes = [ "*.md" ];
  };

  programs.ormolu.enable = true;
  programs.ormolu.package = pkgs.haskell.packages.ghc9122.ormolu;

  # ghcOptsはmoduleが"--ghc-opt -X<ext>"へ展開する。settings.formatter.ormolu.options
  # に直接書くとmoduleのdefaultと連結されてしまうためこちらで指定する。
  # PatternSynonymsはdefaultに含まれるが、有効にするとpatternが予約語になり
  # ローカル関数名patternがparse errorになるため外している。
  programs.ormolu.ghcOpts = [
    "ImportQualifiedPost"
    "BangPatterns"
    "TypeApplications"
  ];
}
