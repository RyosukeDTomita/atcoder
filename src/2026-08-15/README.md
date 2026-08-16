# AtCoder Beginner Contest 471

https://atcoder.jp/contests/abc471

バーチャル参加

## INDEX

- [A - Nine or Nein](https://atcoder.jp/contests/abc471/tasks/abc471_a): 割り算の部分で`div`を使って1ペナ。掛け算にするべし
- [B - Survey Tabulation](https://atcoder.jp/contests/abc471/tasks/abc471_b): `group`して最大を探す。
- [C - Cookies and Greedy Takahashi](https://atcoder.jp/contests/abc471/tasks/abc471_c): ポイントは座標iが常に変わり、そこからもっとも近い座標を探す必要があること。座標の長さ的に都度探索してもTLEしなさそうなので検索コストを抑えるために`Data.Set`を使ってiより小さい座標のうち最大のもの or iより大きい座標のうち最小のものを候補として取り出し距離が近い方に移動することを繰り返す。
