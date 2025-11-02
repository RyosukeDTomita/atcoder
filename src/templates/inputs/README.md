# INPUTS

入力を処理するコード

## 文字列

### 1行

- [1行に1つの文字列](./one_line_one_string.hs): [`getLine`](https://hackage.haskell.org/package/base-4.19.1.0/docs/Prelude.html#v:getLine)は標準入力から**1行**を読み込み、`String`として返す。

```shell
cat <<'EOF' > input.txt
Hello
EOF
runghc one_line_one_string.hs < input.txt && /usr/bin/rm input.txt
Hello
```

- [1行に複数の文字列を配列で受け取る](./one_line_multiple_strings.hs): `getLine`で1行を読み込み、[`words`](https://hackage.haskell.org/package/base-4.19.1.0/docs/Prelude.html#v:words)で`String`を分割して`[String]`を返す。

```shell
cat <<'EOF' > input.txt
Taro Alice
EOF
runghc one_line_multiple_strings.hs < input.txt && /usr/bin/rm input.txt
["Taro","Alice"]
```

- [1行に複数の文字列を分割して受け取る](./one_line_multiple_strings2.hs)

```shell
cat <<'EOF' > input.txt
Hello Alice
EOF
runghc one_line_multiple_strings2.hs < input.txt && /usr/bin/rm input.txt
"Hello"
"Alice"
```

### 複数行

- [複数行に1つの文字列をまとめて配列で受け取る](./multiple_lines_one_string.hs): [`getContents`](https://hackage.haskell.org/package/base-4.19.1.0/docs/Prelude.html#v:getContents)は標準入力から**すべての行**を読み込み、`String`として返す。[`lines`](https://hackage.haskell.org/package/base-4.19.1.0/docs/Prelude.html#v:lines)で改行コードで分割して`[String]`を取得する。

> [!NOTE]
> 分割して受け取りたい場合には複数回`getLine`を呼び出せば良い。

```shell
cat <<'EOF' > input.txt
A
B
C
EOF
runghc multiple_lines_one_string.hs < input.txt && /usr/bin/rm input.txt
["A","B","C"]
```

- [複数行に1つの文字列を取得する(行数が冒頭で指定されている)](./multiple_lines_one_string2.hs)

```shell
cat <<'EOF' > input.txt
3
HOGE
FUGA
PIYO
EOF
runghc multiple_lines_one_string2.hs < input.txt && /usr/bin/rm input.txt
["HOGE","FUGA","PIYO"]

# #と.で構成されるグリッドの問題の場合もこれでいける
cat <<'EOF' > input.txt
3
#.#.
####
....
EOF
runghc multiple_lines_one_string2.hs < input.txt && /usr/bin/rm input.txt
["#.#","####","...."]
```

- [複数行に1つの文字列を取得する(末尾に終了文字がある)](./multiple_line_one_string3.hs)

```shell
# ENDを終了文字として扱う
cat <<'EOF' > input.txt
HOGE
FUGA
PIYO
END
EOF
runghc multiple_line_one_string3.hs < input.txt && /usr/bin/rm input.txt
```

---

## 数値

### 1行

- [1行に1つの数値を受け取る](./one_line_one_int.hs): [`readLn`](https://hackage.haskell.org/package/base-4.19.1.0/docs/Prelude.html#v:readLn)は`getLine`で1行を読み込み、`readIO`で数値に変換して返すという処理をまとめたものである。

```shell
cat <<'EOF' > input.txt
3
EOF
runghc one_line_one_int.hs < input.txt && /usr/bin/rm input.txt
3
```

- [1行に複数の数値を受け取る](./one_line_multiple_int.hs): `getLine`で1行を読み込み、`words`で分割し、[`read`](https://hackage.haskell.org/package/base-4.19.1.0/docs/Prelude.html#v:read)で数値に変換する。

```shell
cat <<'EOF' > input.txt
1 2 3
EOF
runghc one_line_multiple_int.hs < input.txt && /usr/bin/rm input.txt
[1,2,3]
```

### 複数行

- [複数行に1つの数値を配列で取得する](./multiple_line_one_int.hs)

```shell
cat <<'EOF' > input.txt
1
2
3
EOF
runghc multiple_line_one_int.hs < input.txt && /usr/bin/rm input.txt
[1,2,3]
```

- [複数行に1つの数値を取得する(行数が冒頭で指定されている)](./multiple_line_one_int2.hs)

```shell
cat <<'EOF' > input.txt
3
1
2
3
EOF
runghc multiple_line_one_int2.hs < input.txt && /usr/bin/rm input.txt
[1,2,3]
```

- [複数行に1つの数値を取得する(末尾に終了文字がある)](./multiple_line_one_int3.hs)

```shell
# 0を終了文字として扱う
cat <<'EOF' > input.txt
1
2
3
0
EOF
runghc multiple_line_one_int3.hs < input.txt && /usr/bin/rm input.txt
[1,2,3]
```

### 複数行かつ複数列

- [複数行に複数の数値を取得して2次元配列に格納する](./multiple_line_multiple_int.hs)

```shell
cat <<'EOF' > input.txt
1 2 3
4 5 6
7 8 9
EOF
runghc multiple_line_multiple_int.hs < input.txt && /usr/bin/rm input.txt
[[1,2,3],[4,5,6],[7,8,9]]
```

- [複数行に複数の数値を取得して2次元配列に格納する(行数が冒頭に提示)](./multiple_line_multiple_int2.hs)

```shell
cat <<'EOF' > input.txt
3 3
1 2 3
4 5 6
7 8 9
EOF
runghc multiple_line_multiple_int2.hs < input.txt && /usr/bin/rm input.txt
[[1,2,3],[4,5,6],[7,8,9]]
```

- [複数行に複数の数値を取得して2次元配列に格納する(終了文字がある)](./multiple_line_multiple_int3.hs)

```shell
# 終了文字列0が出るまで読み込む
cat <<'EOF' > input.txt
1 2 3
4 5 6
7 8 9
0 0 0
EOF
runghc multiple_line_multiple_int3.hs < input.txt && /usr/bin/rm input.txt
[[1,2,3],[4,5,6],[7,8,9]]
