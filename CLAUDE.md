Haskellで挑戦するAtCoder用リポジトリ

質問に応答するまえに現在編集しているソースコードを再度読み込むこと

## Haskell Conventions

- 競技プログラミングの場合、入出力はinteractを使用する。
- 頂点ごとに隣接リストを集約するなど「同じ添字に複数の値を集約する(グルーピング)」処理は、`Data.Array`の`accumArray`が一行で書けて楽。Vectorだと`ST`+`MVector`か`sort`+`groupBy`が必要で手数が増える。`accumArray (flip (:)) [] (1, n) edges`で隣接リスト(`Array Int [Int]`)を構築できる(`flip`は`accum f`が`f 既存値 新入力`の順で呼ぶため)。
- `_2`を作成する際や、コードをリライトする際に変数名をなるべく維持して生成し、生成後に提案をする。
