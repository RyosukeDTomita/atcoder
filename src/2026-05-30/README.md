# AtCoder Beginner Contest 460

https://atcoder.jp/contests/abc460

## INDEX

- [A - Mod While Positive](https://atcoder.jp/contests/abc460/tasks/abc460_a): naoyaさんの過去の発表資料で学んだ`iterate` + `takeWhile`パターンで解けた。ちょいエレガント
- [B - Two Rings](https://atcoder.jp/contests/abc460/tasks/abc460_b): 円同士が重なるかの問題。どちらかの円がもう一つの円の内部になるパターンを忘れないのが大事。
- [C - Sushi](https://atcoder.jp/contests/abc460/tasks/abc460_c): ネタはシャリの2倍の重さ以下でないといけないという制約があるので、ネタとシャリのデータを事前にsortして貪欲法的にマッチするシャリがないネタを切り捨てていった。
- [D - Repeatedly Repainting ](https://atcoder.jp/contests/abc460/tasks/abc460_d): 10^100回操作を実行すると白と黒が交互に切り替わるパターンに収束する。白マスは次必ず黒になるので、元の黒マスからのチェビシェフ距離が偶数の場所が黒になる。
