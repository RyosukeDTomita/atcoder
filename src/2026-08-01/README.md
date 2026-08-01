# AtCoder Beginner Contest 469

https://atcoder.jp/contests/abc469

## INDEX

- [A - Train Car](https://atcoder.jp/contests/abc469/tasks/abc469_a)
- [B - Isolated Seats](https://atcoder.jp/contests/abc469/tasks/abc469_b): 右端と左端の扱いを別々にしていたが、先頭と末尾に`'x'`を足せば良かった。あと、`zipWith3`でxxxを先頭から探すという例も見て(C_3.hs)を見てこっちのほうがきれいだなと思った。
- [C - Cantrip](https://atcoder.jp/contests/abc469/tasks/abc469_c): 普通に書いたらTLEしたので累積和で解いた。累積和を作り`'o'`が出るたびにstockを1つ増やして累積和を作る。kからスタートし、累積和のk番目まで取得できるあたりの分だけindexを進める。最後stockが0になった位置のindexが答え。
