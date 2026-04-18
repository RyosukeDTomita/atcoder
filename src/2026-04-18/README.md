# Keysight Technologies Programming Contest（AtCoder Beginner Contest 454）

<https://atcoder.jp/contests/abc454>

## INDEX

- [A - Closed interval](https://atcoder.jp/contests/abc454/tasks/abc454_a)
- [B - Mapping](https://atcoder.jp/contests/abc454/tasks/abc454_b): 重複排除して比較しているだけ。もっといい方法はありそう。
- [C - Straw Millionaire](https://atcoder.jp/contests/abc454/tasks/abc454_c): 単純に再帰で書くとaが同じだがbが違うものも落としてしまう。幅優先探索で実施したが、本番中はTLEがとれず。一つの再帰でvisitedとnewNodesを両方更新するようにすることでTLEがとれた。
