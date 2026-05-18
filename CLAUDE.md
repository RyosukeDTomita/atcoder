Haskellで挑戦するAtCoder用リポジトリ

## Haskell Conventions

- `ghc`でチェックすると不要なファイルができるので`runghc`で動作チェックすること。
- パフォーマンス上問題がない場合、モナド/do記法よりも純粋関数を優先する。
- ポイントフリースタイルはなるべく使わない。
- 競技プログラミングの場合、入出力はinteractを使用する。
- 関数の型定義は必ず書く。
- `Data.Array`よりも`Data.Vector`を優先する。
- qualified importを使用する際にはimportしたのがなにかわかりやすくする。 e.g. NG例: `import Data.Set qualified as S` 良い例:  `import Data.Set qualified as Set`
- まず、<file>の現在の状態をもう一度確認すること。前回確認してからユーザが編集した差分を見落とさないため。

