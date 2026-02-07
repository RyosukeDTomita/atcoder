# Data.Vector

## `Data.Vector.Unboxed`

[`Data.Vector.Unboxed`](https://hackage-content.haskell.org/package/vector-0.13.2.0/docs/Data-Vector-Unboxed.html): ポインタを使わずにそのまま、メモリに詰め込まれた型のベクトルを提供する。boxedな型（ポインタを使う型）に比べて、メモリ効率とパフォーマンスが良い。

### `Data.Vector.Unboxed.Mutable`

更新が可能なVectorを提供する。`Data.Vector.Unboxed`のVectorは不変（immutable）であるため、更新を行うには新しいVectorを作成する必要があるが、`Data.Vector.Unboxed.Mutable`のVectorは破壊的に更新できる。

- [リストをVectorに変換する](./fromList.hs)
- [使った複数更新(bulk update)](https://hackage-content.haskell.org/package/vector-0.13.2.0/docs/Data-Vector-Unboxed.html#g:15): Vectorの長さをm、更新するインデックス/値のペアのリストの長さをnとしたとき、O(m+n)で更新を行う。Vector全体をコピーして差し替えのため速くはないが、簡潔に書ける。
  - [bulkUpdate.hs](./bulkUpdate.hs): `//`は`[(Int, Int)]`で更新情報を渡す。`update`は`Vector (Int, a)`で更新情報を渡す。
- [`VUM.modify`を使った破壊的更新](https://hackage-content.haskell.org/package/vector-0.13.2.0/docs/Data-Vector-Unboxed.html#g:18): 安全でない場合にのみVectorのコピーを更新する。O(1)で更新できるため高速。
  - [modify.hs](./modify.hs): `VUM.modify`を使って配列を更新する。
  - [increment.hs](./increment.hs): `[Int]`の出現回数を記録する
