#!/bin/zsh
set -e

# Nixストアの権限を修正(ボリュームが初めて作成された場合root所有になるため)
if [ -d /nix ] && [ ! -w /nix ]; then
  echo "Fixing /nix permissions..."
  sudo chown -R vscode: /nix
fi

# direnvキャッシュの権限を修正
if [ -d /home/vscode/.local/share/direnv ] && [ ! -w /home/vscode/.local/share/direnv ]; then
  echo "Fixing direnv cache permissions..."
  sudo chown -R vscode: /home/vscode/.local/share/direnv
fi

# Install Nix if not already installed
if [ ! -d /nix/store ]; then
  echo "Installing Nix..."
  curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install | sh -s -- --no-daemon
fi

# Set up user config for flakes
mkdir -p /home/vscode/.config/nix
echo "experimental-features = nix-command flakes" | tee /home/vscode/.config/nix/nix.conf

# Setup direnv hooks dotfiles経由の.zshrdに記載があるのでコメントアウト
# echo 'eval "$(direnv hook bash)"' >> /home/vscode/.bashrc
# echo 'eval "$(direnv hook zsh)"' >> /home/vscode/.zshrc

# Nixプロファイルを読み込む
if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
  source ~/.nix-profile/etc/profile.d/nix.sh
fi

# Install nix-direnv
echo "Installing nix-direnv..."
nix profile install nixpkgs#nix-direnv

# Setup direnvrc for nix-direnv
mkdir -p /home/vscode/.config/direnv
cat > /home/vscode/.config/direnv/direnvrc << 'EOF'
if [ -f "$HOME/.nix-profile/share/nix-direnv/direnvrc" ]; then
  source "$HOME/.nix-profile/share/nix-direnv/direnvrc"
elif [ -f "/nix/var/nix/profiles/default/share/nix-direnv/direnvrc" ]; then
  source "/nix/var/nix/profiles/default/share/nix-direnv/direnvrc"
elif [ -f "/run/current-system/sw/share/nix-direnv/direnvrc" ]; then
  source "/run/current-system/sw/share/nix-direnv/direnvrc"
fi
EOF

# direnvを許可して新しいシェルで自動的に環境がロードされるように
echo "Allowing direnv for workspace..."
cd /workspaces/atcoder
direnv allow

echo "Setup complete!"