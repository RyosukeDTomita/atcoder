# INPUTS(main=interactを使用するバージョン)

## 文字列

---

## 数値

### 1行

- [1行に複数の数値を取得して配列に格納する](./one_line_multiple_int.hs)

```shell
cat <<'EOF' > input.txt
1 2 3
EOF
runghc one_line_multiple_int.hs < input.txt && /usr/bin/rm input.txt
1 2 3
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
1
2
3
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
1
2
3
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
1
2
3
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
1 2 3
4 5 6
7 8 9
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
1 2 3
4 5 6
7 8 9
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
1 2 3
4 5 6
7 8 9
```
