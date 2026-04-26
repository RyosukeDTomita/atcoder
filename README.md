# AtCoder

[![AtCoder Trophies](https://atcoder-trophies.vercel.app/api/v1/atcoder?username=HathawayNoa&theme=tokyonight&rank=SSS,SS,S,AAA,AA,A,B)](https://github.com/KATO-Hiro/AtCoderTrophies)

## INDEX

- [ABOUT](#about)
- [ENVIRONMENT](#environment)
- [HOW TO USE](#how-to-use)

---

## ABOUT

過去自分が参加した[AtCoder](https://info.atcoder.jp/)のコンテストの解答管理用リポジトリ。
問題文は[AtCorderの知的財産権](https://atcoder.jp/tos)に属するため、ここには記載しない。

> [!WARNING]
> 本リポジトリには、**コンテスト期間外**に復習のため作成した生成AI使用のコードが含まれています。コンテスト期間においては生成AIを使用せず、参加しています。

---

## ENVIRONMENT

```shell
nix develop
```

### VS Code Extensions

VS CodeのExtensionsである`haskell.haskell`をインストールする。
`atcoder/.vscode/settings.json`に設定を記載しているので、VS Codeで`atcoder`ディレクトリを開けば自動的に認識される。

---

## HOW TO USE

コンテストに参加する前にその日のコンテスト用ディレクトリを作成する

```shell
cd src
./create_today_dir.sh
```

Haskellのコードを実行する

```shell
# コンパイルして実行する
ghc <file_name>.hs
./<file_name>
```

```shell
# インタプリタで実行する
runghc <file_name>.hs
```

```shell
# 入力データをtxtファイルから受け取って実行する(これが一番競技プログラミングに向いてそう?)
runghc <file_name>.hs < input.txt
```

```shell
# 対話形式で実行する
ghci
ghci> putStrLn "Hello, World!"
Hello, World!
ghci> :q
Leaving GHCi.
```

```shell
# Formatter(CLIで実行したい場合)
ormolu --mode inplace $(find . -type f -name "*.hs")
```

### ghci

import文の自動読み込み設定を[.ghci](./.ghci)に記載している。

`.ghci`はルートディレクトリ(atcoder/)に置いているが、atdoer/src/等に移動した際には読み込まれない。そのため、グローバルに読み込むためにシンボリックリンクをホームディレクトリに作成する。

```shell
cd atcoder
ln -s /home/sigma/atcoder/.ghci /home/sigma/.ghci
```
