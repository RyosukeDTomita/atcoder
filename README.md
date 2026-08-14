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

GHC 9.8.4

```shell
nix develop
```

### Zed User

- `haskell`のExtensionsをインストールする。
- \`[settings.json](./.zed/settings.json)に設定を配置している。これで、LSPやフォーマッタ等が使えるようになる。
- プロジェクト固有のスニペット機能は2026年5月現在ではサポートされていないので、VS CodeのスニペットをZed用に移植したものをグローバルに配置して使用している。

---

## HOW TO USE

コンテストに参加する前にその日のコンテスト用ディレクトリを作成する

```shell
cd src
./create_today_dir.sh
```

コンテスト終了後にREADME.md作成する

```shell
cd src
./create_readme.sh abcxxx <ディレクトリ名>
```

Haskellのコードを実行する

```shell
# 入力データをtxtファイルから受け取って実行する(これが一番競技プログラミングに向いてそう?)
runghc <file_name>.hs < input.txt
```

### Format

```shell
# Formatter(CLIで実行したい場合)
nix fmt
```

### ghci

import文の自動読み込み設定を[.ghci](./.ghci)に記載している。

`.ghci`はルートディレクトリ(atcoder/)に置いているが、atdoer/src/等に移動した際には読み込まれない。そのため、グローバルに読み込むためにシンボリックリンクをホームディレクトリに作成する。

```shell
cd atcoder
ln -s /home/sigma/atcoder/.ghci /home/sigma/.ghci
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
# .hsファイルを読みこんで関数を呼び出す。

ghci hoge.hs
ghci> solve 1
1
```

```shell
# 型
ghci>:t foldl
# info
ghci>:i foldl
# kind
ghci>:k Int
```
