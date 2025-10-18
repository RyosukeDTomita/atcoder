# AtCoder

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

- Haskell

```shell
apt-get update -y
apt-get install --no-install-recommends -y \
  build-essential \
  curl \
  ca-certificates \
  libffi-dev \
  libffi8 \
  libgmp-dev \
  libgmp10 \
  libncurses-dev \
  libncurses5 \
  libtinfo5 \
  pkg-config

# ghcupのインストール
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh
```

```shell
# Formatterのormoluのインストール
cabal install ormolu
```

### VS Code Extensions

`ghcup`をインストール後にVS CodeのExtensionsである`haskell.haskell`をインストールし、ポップアップにしたがって`ghc`や`hls`をインストールする。

> [!NOTE]
> Dev Containers環境も作り、`hashkell.haskell`のポップアップでインストールするツールを事前インストールするようにしているが、Extensions側でサポートするバージョンが変わった場合にDockerfileを更新するのが面倒なのでローカルをメインで使うほうが良さそう。

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
