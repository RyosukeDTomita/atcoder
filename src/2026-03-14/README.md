# AtCoder Beginner Contest 449

<https://atcoder.jp/contests/abc449>

## INDEX

- [A - π](https://atcoder.jp/contests/abc449/tasks/abc449_a)
- [B - Deconstruct Chocolate](https://atcoder.jp/contests/abc449/tasks/abc449_b): `MapAccumL`を使って解けた。
- [C - Comfortable Distance](https://atcoder.jp/contests/abc449/tasks/abc449_c)
  - 方針1: `Data.Map`を使い、最初に各文字をキーとしてその文字が出現するインデックスを持ったリストを値とするマップを作る。その後、二分探索を使い、`i`に対応する最小の`j`を求めることで解くパターン
  - 方針2: スライディングウィンドウ方式を使って各`i`に対して`s[i]`と同じ文字が範囲内にいくつあるか求めるパターン
