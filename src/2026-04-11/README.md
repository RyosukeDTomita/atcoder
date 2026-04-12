# AtCoder Beginner Contest 453

<https://atcoder.jp/contests/abc453>

## INDEX

- [A - Trimo](https://atcoder.jp/contests/abc453/tasks/abc453_a): 再帰書いたけど、`dropWhile(=='o')`で良かった。
- [B - Sensor Data Logging](https://atcoder.jp/contests/abc453/tasks/abc453_b): `mapAccumL`しつつ、保存しなくて良いデータがあったので`Nothing`にして、最後に`catMaybes`で消す。
- [C - Sneaking Glances](https://atcoder.jp/contests/abc453/tasks/abc453_c): 貪欲法的に都度、0に近づくようにしたが、うまくいかず。全探索したら通った。
