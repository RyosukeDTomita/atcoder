# BASIC SYNTAX

## INDEX

- [`replicateM_`を使って処理をリピートする](./repeat.hs): replicateM_を使った処理の繰り返し
- [`when`をif文の代わりに使い、`exitSuccess`で抜ける(早期return的な動き)](./when.hs): when関数を使うと`if`の`else`部分を省略できる。終了するには`exitSuccess`が必要。
  > [!NOTE]
  > Haskellの`if`は`else`が必須。
- [`take`と`drop`でリストから特定の要素を削除する](./take_drop.hs): takeとdropを使ったリストの要素削除
- [`let`と`where`の使い方](./let_where.hs): letとwhereの使いかた。
- [lambda式の使い方](./lambda.hs)
  - 1つの引数のlambda式
  - 2つの引数のlambda式
- [リスト内包表記と同じ動作をするコード例](./list_comprehension.hs)
- [数値に変換する](./toInt.hs): `digitToInt`を使った文字から数値への変換。
- [割り算まとめ](./division.hs) : `div`, `mod`, `quot`、`divMod`の違い。`/`を使う時には`fromIntegral`が必要。
