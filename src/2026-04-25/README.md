# Ｓｋｙ Inc, Programming Contest 2026 (AtCoder Beginner Contest 455)

<https://atcoder.jp/contests/abc455>

## INDEX

- [A - 455](https://atcoder.jp/contests/abc455/tasks/abc455_a)
- [B - Spiral Galaxy](https://atcoder.jp/contests/abc455/tasks/abc455_b): 機械的に解けたが、何に対する点対称なのか若干ハマった。
- [C - Vanish](https://atcoder.jp/contests/abc455/tasks/abc455_c): 最初はVectorを使い、各数字が何個ずつあるかを数えていたが、Aが10^9オーダであったため、Aにでかい値があるとメモリが足りなくなった。そこで、`group`を使い、同じ数字が連続している部分をまとめ、数xとその個数を掛け算して数xを消した場合にどれだけ答えが減るかを計算するようにした。
