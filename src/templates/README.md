# Templates

## ABOUT

Atcoderの競技プログラミング用に、よく使うコードをまとめたテンプレート集。

---

## INDEX

### SYNTAX

よく使うが使い方を忘れがちな文法

- [`replicateM_`を使って処理をリピートする](./repeat.hs): replicateM_を使った処理の繰り返し
- [`elem`を使ってリスト内の要素をチェックする](./elem.hs): elem関数を使ったリスト内の要素存在チェック
- [`when`をif文の代わりに使い、`exitSuccess`で抜ける(早期return的な動き)](./when.hs): when関数を使うと`if`の`else`部分を省略できる。終了するには`exitSuccess`が必要。
  > [!NOTE]
  > Haskellの`if`は`else`が必須。
- [`take`と`drop`でリストから特定の要素を削除する](./take_drop.hs): takeとdropを使ったリストの要素削除
- [`let`と`where`の使い方](./let_where.hs): letとwhereの使いかた。
- [lambda式の使い方](./lambda.hs): カリー化された関数を無名関数で書く方法も含む。

### FUNCTIONS

よく使う関数

- [リストの要素をカウントする](./functions/frequency2.hs): リスト内の特定の要素の個数を数える関数とその使用例
