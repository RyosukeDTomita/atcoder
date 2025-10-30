# Reinventing the Wheel

## ABOUT

既存のライブラリを再定義することで、基礎的な概念を深く理解することを目的とする。

[main.hs](./main.hs)から呼び出せるようになっていれば一旦、ヨシとする。

---

## INDEX

- [`Length`](./Length.hs): [`length`](https://hackage.haskell.org/package/base-4.19.1.0/docs/Prelude.html#v:length)を`再帰`と`foldr`の二種類で実装した。
  - `length'`
  - `length''`

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
  - `map'`
  - `map''`
- [`Scan`](./Scan.hs): [`scanl`](https://hackage.haskell.org/package/base-4.19.1.0/docs/Prelude.html#v:scanl)と[`scanr`](https://hackage.haskell.org/package/base-4.19.1.0/docs/Prelude.html#v:scanr)を実装した。
  - `scanl'`
  - `scanr'`

---

## ENVIRONMENT

- ファイル名は大文字スタートにしないといけなさそう。
- `module Length (length', length'') where`のようにしてエクスポートする関数を指定する。
- `hie.yaml`によりHSLに認識されるようになっている。
