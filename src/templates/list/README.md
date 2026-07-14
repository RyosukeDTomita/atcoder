# List操作関連

## INDEX

- [関数適用をリストに対して`map`できる](./mapFunc.hs)

- [文字列`Char[]`を数値に変換する。逆も](./charToInt.hs):

- [リストから要素を取り出す](./accessing_elements.hs): `head`, `tail`, `last`, `init`の使い方。`Data.Vector`との比較も。

- [`intercalate`でリストを結合する](./intercalate.hs): 区切り文字月で結合できる。

- [文字列からパターンを取得する](./pattern.hs)

  - `subsequences`で部分列を取得(ここでいう部分列とは、元の列から0個以上の要素を取り出して残りの順番を保ったもの)
  - `permutations`で順列(並び替えのパターン)を取得
  - 文字と文字の間をとって結合するのが許されないタイプの部分列を探すのには、`tails`が役に立つ
  - すべての組み合わせをもとめるのは[`replicateM`](../monad/replicateM_.hs)を使う

- [isOf系のまとめ](./isOf.hs): 部分文字列を探す京

  - `isPrefixOf`: 前方一致で存在をチェック=前方に一致している文字列がなければFalse

  - `isSuffixOf`: 後方一致で存在をチェック=後方に一致している文字列がなければFalse

  - `isInfixOf`: ある単語が含まれるか(連続分文字列を含むか)をチェック。`elem`は`Char`にしか使えない(1文字単位のマッチング)ので`isInfixOf`を使う必要があることに注意。

    ```haskell
    -- こういうのはできる
    ghci> filter(`elem` "ij") "abcdefgijklmnoibj" -- filterを使うと"abcdefgijklmnoibjの要素を1文字ずつに分解してチェックする `'a' `elem` "ij"`みたいな
    "ijij"
    ```

  - `isSubSequenceOf`

- [Boolリストの集計](./boolList.hs)

  - `and`で全要素がTrueかチェック
  - `or`で一つでもTrueがあるかチェック
  - `all`で指定した関数に対して全要素が条件を満たすかチェック
  - `any`で指定した関数に対して条件を満たす要素があるかチェック

- [状態を持ちながらリストを走査する](./stateList.hs)

  - `mapAccumL`
  - `iterate`

- [リストの基本操作](./basic.hs): `elem`での要素存在チェックと`find`での要素探索(Maybeを返す)

- [無限リストを扱う](./infinite_lists.hs)

  - `repeat`: 単一要素を無限回繰り返す
  - `cycle`: リストを無限回繰り返す
  - `replicate`: 無限は使えない

- [様々なソート](./sort.hs)

  - 昇順
  - 降順
  - tupleの2番目の要素でソート

- [2次元行列の転置](./transpose.hs): 2次元行列の転置

- [リストの分割](./splitting_lists.hs)

  - `splitAt`を使い、配列を2つに分割する: `take`と`drop`の組み合わせよりも簡潔に書ける。
  - `span`
  - `break`
  - `partition`: 全要素を条件のTrue/Falseで2つに振り分ける(登場位置での分割ではない)
  - `uncons`

- [条件でリストをふるいにかける](./filtering_lists.hs)

  - `filter`
  - `takeWhile`: Falseが出たら以降のリストを切り捨てる --> 無限リストを止められる
  - `dropWhile`: Trueを捨てて、Falseが出たらそれ以降を取得する
  - `dropWhileEnd`: リストの末尾から条件を満たす要素を削除する

- [リストから該当する要素を1つ見つける](./find.hs)

  - `find`: Trueで止まるので1つだけ要素を見つけたい場合には`filter`や`map`よりも計算量が少なくすむ。`Maybe`を返すので`case`を使ってデフォルト値を設定すると良さそう。

- [`takeWhile`で条件を満たすまでリストに要素を追加する](./takeWhile_roop.hs): 上限までかごにりんごを詰める例

- [リストモナドと内包表記比較](./listMonad.hs)

---

## サンプルコードを書くまでもないが便利な関数

- [`group`](https://hackage-content.haskell.org/package/base-4.22.0.0/docs/Data-List.html#v:group)
