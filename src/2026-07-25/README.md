# AtCoder Beginner Contest 468

https://atcoder.jp/contests/abc468

## INDEX

- [A - Maximal Value](https://atcoder.jp/contests/abc468/tasks/abc468_a): 再帰で突破
- [B - Corridor Watch](https://atcoder.jp/contests/abc468/tasks/abc468_b): 自分はガードマンのいるますの前後`d`を`Set`に放り込んで解いた。`[0..d]`して`[x-d, x+d]`するんじゃなくて`[-d..d]`すれば良かった。あと、微々たる差かもしれないが、各マスの前後-dからdの間にガードマンがいるかを探しても良かった気がする。
- [C - Between P and Q](https://atcoder.jp/contests/abc468/tasks/abc468_c): `permutations`してsortし、P、Qが辞書順でn番目かを`elemIndex`して調べたらTLE。P、Qが辞書順でn番目かを数え上げることでACできた。　`(x : rest) k = length (filter (< x) rest) * product [1..k] + go rest (k - 1)`のように先頭から1桁ずつその桁が来る前に最低何個の順列があるかを求める感じ。でももっと楽なのはストリーミングを意識してsortせずに内包表記でP\<p\<Qだけ残すようにすればsortを踏まないのでTLEしない。
  - sortが高くつく理由は2つ。(1)sortは最後の要素を確定させるのに全入力を読むので、リストが全部メモリに乗る。(2)マージのたびに新しいconsセルを作るのでメモリ量がふえる。ストリーミング風に流せば要素を都度GCできる。
  - GHCはコピーGCなので、コストは生存量に比例しゴミの量には比例しない。
