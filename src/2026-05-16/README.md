# AtCoder Beginner Contest 458
動画2つ

https://atcoder.jp/contests/abc458

## INDEX

- [A - Chompers](https://atcoder.jp/contests/abc458/tasks/abc458_a): Data.List.Extraに`dropEnd`という素敵な関数があるらしい。`dropEnd n xs = zipWith const xs (drop n xs)`
- [B - Count Adjacent Cells](https://atcoder.jp/contests/abc458/tasks/abc458_b): リスト内包表記で右側の角でないなら+1、左側の角でないなら+1、縦方向の辺でないなら+1、横方法の辺でないなら+1とした。
- [C - C Stands for Center](https://atcoder.jp/contests/abc458/tasks/abc458_c): Cのindexを先に探しておき、そのindexが中央より右側か左側かをもとめて足していく
- [D - Chalkboard Median](https://atcoder.jp/contests/abc458/tasks/abc458_d): 単純な頻度マップを更新していく方針ではTLE
