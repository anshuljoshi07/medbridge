#!/usr/bin/env bash
# One-time Codespace setup: Flutter (stable), Serverpod CLI, dependencies.
set -euo pipefail
sudo apt-get update -y
sudo apt-get install -y --no-install-recommends build-essential clang curl git unzip xz-utils zip
if [ ! -d "$HOME/flutter" ]; then
  git clone --depth 1 -b stable https://github.com/flutter/flutter.git "$HOME/flutter"
fi
echo 'export PATH="$PATH:$HOME/flutter/bin:$HOME/.pub-cache/bin"' >> "$HOME/.bashrc"
export PATH="$PATH:$HOME/flutter/bin:$HOME/.pub-cache/bin"
flutter config --no-analytics --enable-web
flutter precache --web
dart pub global activate serverpod_cli
cd medbridge && flutter pub get
