# Tokio Marine &amp; Nichido Fire Insurance Programming Contest 2026  (AtCoder Beginner Contest 459)

https://atcoder.jp/contests/abc459

## INDEX

- [A - Hell, World!](https://atcoder.jp/contests/abc459/tasks/abc459_a): `splitAt`で分割したあと`tail`しているのであんまり効率は良くない。`zip`して文字の場所のindexつけるのが良さそう。
- [B - 459](https://atcoder.jp/contests/abc459/tasks/abc459_b): 力技を使った。ワードのリストを作ってindexとzipして内包表記するほうが多分マシ
- [C - Drop Blocks](https://atcoder.jp/contests/abc459/tasks/abc459_c): 破壊的代入をするとコードが汚くなって買った気がしない。肝としては、全消しした回数=マスに置かれているデータの個数の最小値であることと、>=kのマスの数を保存するデータ構造が大事。
