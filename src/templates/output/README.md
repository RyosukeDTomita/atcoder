# OUTPUTS

## INDEX

- [2種類の関数を1つのprint内で実行して出力する](./print_two_calls.hs)
- [配列の数だけprintを繰り返す](./print_list_elements.hs): [`mapM_`](https://hackage.haskell.org/package/base-4.19.1.0/docs/Prelude.html#v:mapM_)を使い、モナド内で繰り返し処理を行う方法。`mapM`と違い、結果を無視する。
- [配列の数だけprintを繰り返す(ループカウンタ付き)](./print_list_elements2.hs): [`zip`](https://hackage.haskell.org/package/base-4.19.1.0/docs/Prelude.html#v:zip)を使い、無限リストをインデックス番号を取得して出力に利用する。
- [2次元配列を出力する](./print_2d_array.hs)
- [小数点以下を指定した桁だけ出力する](./printf_fixed_decimal.hs)
