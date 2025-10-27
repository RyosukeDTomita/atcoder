FROM haskell:slim-bookworm

RUN --mount=type=cache,target=/var/cache/apt \
    --mount=type=cache,target=/var/lib/apt/lists \
    apt-get update -y && \
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
      pkg-config && \
    rm -rf /var/lib/apt/lists/*

# NOTE: https://www.haskell.org/ghcup/ のとおりにやるとビルド中に止まるので直接取得に変更
RUN <<EOF bash -ex
mkdir -p /root/.ghcup/bin
curl -fsSL https://downloads.haskell.org/~ghcup/x86_64-linux-ghcup -o /root/.ghcup/bin/ghcup
chmod +x /root/.ghcup/bin/ghcup
EOF

# ghcup を PATH に追加
ENV PATH="/root/.ghcup/bin:$PATH"

# 各ツールを ghcup で明示的にインストール
RUN ghcup install ghc 9.6.7 && \
    ghcup set ghc 9.6.7 && \
    ghcup install cabal 3.12.1.0 && \
    ghcup set cabal 3.12.1.0 && \
    ghcup install stack 3.3.1 && \
    ghcup set stack 3.3.1 && \
    ghcup install hls 2.11.0.0 && \
    ghcup set hls 2.11.0.0

# install ormolu formatter
RUN <<EOF bash -ex
cabal update
cabal install ormolu
cabal install --lib vector
cabal install --lib containers
EOF

