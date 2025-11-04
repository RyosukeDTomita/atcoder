# Reinventing the Wheel

## ABOUT

既存のライブラリを再定義することで、基礎的な概念を深く理解することを目的とする。

[main.hs](./main.hs)から呼び出せるようになっていれば一旦、ヨシとする。

---

## INDEX

- [`Length`](./Length.hs): original: [`length`](https://hackage.haskell.org/package/base-4.19.1.0/docs/Prelude.html#v:length)
  - `length'`: 再帰 version
  - `length''`: foldr version
- [`Reverse`](./Reverse.hs): original: [`reverse`](https://hackage.haskell.org/package/base-4.19.1.0/docs/Prelude.html#v:reverse)
  - `reverse'`: 再帰 version
  - `reverse''`: `foldl` version
  - `reverse'''`: `foldr` version
- [`Concat`](./Concat.hs): original: [`concat`](https://hackage.haskell.org/package/base-4.19.1.0/docs/Prelude.html#v:concat)
  - `concat'`: リストのみを結合する version
  - `concat''`: 任意の型を結合する version

### higher-order functions(高階関数)

- [`Fold`](./Fold.hs): [`foldl`](https://hackage.haskell.org/package/base-4.19.1.0/docs/Prelude.html#v:foldl)と[`foldr`](https://hackage.haskell.org/package/base-4.19.1.0/docs/Prelude.html#v:foldr)を実装した。
  - `foldl'`
  - `foldr'`
- [`Filter`](./Filter.hs): [`filter`](https://hackage.haskell.org/package/base-4.19.1.0/docs/Prelude.html#v:filter)を再帰で実装した。
  - `filter'`
- [`Zip`](./Zip.hs): [`zipWith`](https://hackage.haskell.org/package/base-4.19.1.0/docs/Prelude.html#v:zipWith)を再帰で[`zip`](https://hackage.haskell.org/package/base-4.19.1.0/docs/Prelude.html#v:zip)を`zipWith`を使って実装した。
  - `zipWith'`
  - `zip'`
- [`Map`](./Map.hs): [`map`](https://hackage.haskell.org/package/base-4.19.1.0/docs/Prelude.html#v:map)を再帰と`foldr`の二種類で実装した。
  - `map'`: 再帰 version
  - `map''`: foldr version
- [`Scan`](./Scan.hs): [`scanl`](https://hackage.haskell.org/package/base-4.19.1.0/docs/Prelude.html#v:scanl)と[`scanr`](https://hackage.haskell.org/package/base-4.19.1.0/docs/Prelude.html#v:scanr)を実装した。
  - `scanl'`
  - `scanr'`

---

## ENVIRONMENT

- ファイル名は大文字スタートにしないといけなさそう。
- `module Length (length', length'') where`のようにしてエクスポートする関数を指定する。
- `hie.yaml`によりHSLに認識されるようになっている。
