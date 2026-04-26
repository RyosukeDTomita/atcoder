# Data.Vector

## `Data.Vector`

どんな型でも格納できるが、`VU`に比べてメモリ効率やパフォーマンスが悪いため、競技プログラミングの文脈で使うことはあまりなさそう。

______________________________________________________________________

## `Data.Vector.Unboxed`

[`Data.Vector.Unboxed`](https://hackage-content.haskell.org/package/vector-0.13.2.0/docs/Data-Vector-Unboxed.html): ポインタを使わずにそのまま、メモリに詰め込まれた型のベクトルを提供する。boxedな型（ポインタを使う型）に比べて、メモリ効率とパフォーマンスが良い。

- 更新処理が必要な場合には、コピーして新しいVectorを作ることになる(Immutable Vector)

- 同じVectorを2回以上使用する場合にはStream Fusionという最適化がなくなるため、書き方を工夫したほうが良い。

- [stream Fusionを意識して書き直した例](./VU/streamFusion.hs)

- [Vectorを作る](./VU/createVU.hs)

  - `fromList`を使い、ListからVectorを作る方法
  - `enumFromN`を使った連番のVectorを作る方法

- [使った複数更新(bulk update)](https://hackage-content.haskell.org/package/vector-0.13.2.0/docs/Data-Vector-Unboxed.html#g:15): Vectorの長さをm、更新するインデックス/値のペアのリストの長さをnとしたとき、O(m+n)で更新を行う。Vector全体をコピーして差し替えのため速くはないが、簡潔に書ける。

- [bulkUpdate.hs](./VU/bulkUpdate.hs): `//`は`[(Int, Int)]`で更新情報を渡す。`update`は`Vector (Int, a)`で更新情報を渡す。

- [imap.hs](./VU/imap.hs): index番号と値で計算をしたい時に使 頻度mapを作った後などに有効かも。

______________________________________________________________________

## `Data.Vector.Unboxed.Mutable`

- 更新が可能なVectorを提供する

  - メモリを書き換えるため、モナド内で使用する必要がある

- `Data.Vector.Unboxed`で記載した通り、二回以上更新する場合にはStream Fusionが効かなくなるため、Data.Vector.Unboxed.Mutableを使うほうがパフォーマンスが良くなる。

- [`VUM.modify`を使った破壊的更新](https://hackage-content.haskell.org/package/vector-0.13.2.0/docs/Data-Vector-Unboxed.html#g:18): 安全でない場合にのみVectorのコピーを更新する。O(1)で更新できるため高速。

  - [modify.hs](./VUM/modify.hs): `VUM.modify`を使って配列を更新する。
  - [increment.hs](./VUM/increment.hs): `[Int]`の出現回数を記録する
