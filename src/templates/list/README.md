# List操作関連

## INDEX

- [リストから要素を取り出す](./accessing_elements.hs): `head`, `tail`, `last`, `init`の使い方。`Data.Vector`との比較も。
- [`intercalate`でリストを結合する](./intercalate.hs): 区切り文字月で結合できる。
- [文字列からパターンを取得する](./pattern.hs)
  - `subsequences`で部分列を取得
  - `permutations`で順列を取得
- [isOf系のまとめ](./isOf.hs)
  - `isPrefixOf`
  - `isSuffixOf`
  - `isInfixOf`: `elem`は`Char`にしか使えないので`isInfixOf`を使う必要があることに注意。
  - `isSubSequenceOf`
- [Boolリストの集計](./bool_list.hs)
  - `and`で全要素がTrueかチェック
  - `or`で一つでもTrueがあるかチェック
  - `all`で指定した関数に対して全要素が条件を満たすかチェック
  - `any`で指定した関数に対して条件を満たす要素があるかチェック
- [状態を持ちながらリストを走査する](./stateList.hs)
  - `mapAccumL`
  - `iterate`
- [`elem`を使ってリスト内の要素をチェックする](./elem.hs): elem関数を使ったリスト内の要素存在チェック
- [無限リストを扱う](./infinite_lists.hs)
  - `repeat`
  - `replicate`
  - `cycle`
- [cycle関数で無限リストを作成する](./cycle.hs): cycle関数を使った特定のパターンの無限リスト作成
- [様々なソート](./sort.hs)
  - 昇順
  - 降順
  - tupleの2番目の要素でソート
- [2次元行列の転置](./transpose.hs): 2次元行列の転置
- [partitionを使ったリストの分割](./partition.hs)
- [リストの分割](./splitting_lists.hs)
  - `splitAt`を使い、配列を2つに分割する: `take`と`drop`の組み合わせよりも簡潔に書ける。
  - `span`
  - `break`
- [条件でリストをふるいにかける](./filtering_lists.hs)
  - `filter`
  - `takeWhile`: Falseが出たら以降のリストを切り捨てる --> 無限リストを止められる
  - `dropWhile`: Trueを捨てて、Falseが出たらその以降を取得する
  - `dropWhileEnd`: リストの末尾から条件を満たす要素を削除する

- [`takeWhile`で条件を満たすまでリストに要素を追加する](./takeWhile_roop.hs): 上限までかごにりんごを詰める例
