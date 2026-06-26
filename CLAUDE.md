Haskellで挑戦するAtCoder用リポジトリ

## Haskell Conventions

- 競技プログラミングの場合、入出力はinteractを使用する。
- qualified importを使用する際にはimportしたのがなにかわかりやすくする。 e.g. NG例: `import Data.Set qualified as S` 良い例: `import Data.Set qualified as Set`
- まず、<file>の現在の状態をもう一度確認すること。前回確認してからユーザが編集した差分を見落とさないため。
- 頂点ごとに隣接リストを集約するなど「同じ添字に複数の値を集約する(グルーピング)」処理は、`Data.Array`の`accumArray`が一行で書けて楽。Vectorだと`ST`+`MVector`か`sort`+`groupBy`が必要で手数が増える。`accumArray (flip (:)) [] (1, n) edges`で隣接リスト(`Array Int [Int]`)を構築できる(`flip`は`accum f`が`f 既存値 新入力`の順で呼ぶため)。
