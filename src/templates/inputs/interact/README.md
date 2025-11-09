# INPUTS(main=interactを使用するバージョン)

## 文字列

---

## 数値

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
```
