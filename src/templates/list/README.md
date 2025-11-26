# List操作関連

## INDEX

- [`elem`を使ってリスト内の要素をチェックする](./elem.hs): elem関数を使ったリスト内の要素存在チェック
- [cycle関数で無限リストを作成する](./cycle.hs): cycle関数を使った特定のパターンの無限リスト作成
- [様々なソート](./sort.hs)
  - 昇順
  - 降順
  - tupleの2番目の要素でソート
- [2次元行列の転置](./transpose.hs): 2次元行列の転置
- [partitionを使ったリストの分割](./partition.hs)
- [`splitAt`を使い、配列を2つに分割する](./splitAt.hs): `take`と`drop`の組み合わせよりも簡潔に書ける。
- [isOf系のまとめ](./isOf.hs): `isPrefixOf`, `isSuffixOf`, `isInfixOf`、`isSubSequenceOf`の使い方まとめ。`elem`は`Char`にしか使えないので`isInfixOf`を使う必要があることに注意。
