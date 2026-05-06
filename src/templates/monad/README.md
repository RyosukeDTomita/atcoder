# Operations.Monad

## INDEX

- [`forM_`](./forM_.hs): 手続き型言語の`for`のようなループを実現するための関数。

- [`replicateM_`](./replicateM_.hs): 指定された回数だけアクションを繰り返すための関数。

  - [`replicateM`](https://hackage-content.haskell.org/package/base-4.22.0.0/docs/Control-Monad.html#v:replicateM): `replicate`と異なり、モナドのアクションを繰り返すための関数。
  - [`replicateM_`](https://hackage-content.haskell.org/package/base-4.22.0.0/docs/Control-Monad.html#v:replicateM_): `replicateM`の結果を保持しないバージョン。

- 破壊的代入

  - [IORefを使った変数の破壊的代入](./IORef.hs): `IORef`等を使うとBox化が避けられない --> メモリ上での値の書き換えではなく、新しい値のヒープを確保する動作になるためあまり効率が良くない。

  - [末尾再帰呼び出しバージョン](./IORefAlt.hs): 末尾再帰呼出し(関数の最後の評価ステップが自分自身を呼び出す)を使うほうが良い。

    > [!NOTE]
    > 末尾再帰呼び出しの場合はヒープ確保ではなく、引数をレジスタで持ち回すことができるため、効率が良い。

  - [`StateT`を使ったバージョン](./StateT.hs):

  - [unboxed vectorを使ったバージョン](./unboxedVector.hs)

  ```shell
  time ./IORef
  2500000050000000
  ./IORef  8.77s user 0.01s system 100% cpu 8.777 total
  time ./IORefAlt # 末尾再帰呼び出しのほうが速い。
  2500000050000000
  ./IORefAlt  4.51s user 0.01s system 100% cpu 4.517 total
  time ./StateT                     130
  ./StateT  13.94s user 0.03s system 100% cpu 13.947 total
  time ./unboxedVector
  ./unboxedVector  10.12s user 0.01s system 100% cpu 10.125 total
  ```

- [リストモナド](./listMonad.hs): `>>=`、`do`式、リスト内包表記の3つの書き方で全組み合わせ生成とフィルタを実装。
- [`pure`について](./pure.hs): [`pure`](https://hackage-content.haskell.org/package/base-4.22.0.0/docs/Control-Applicative.html#v:pure)のliftするという感覚がわからなかったので検証した。型変換と違い、値が変わらず、コンテナを変えるイメージらしい? そのため、IntをFloatにするのは落ちる。
