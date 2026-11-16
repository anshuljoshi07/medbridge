#!/usr/bin/env bash
# CI gate for med_core (B1): codegen → format → analyze → tests. Fails fast.
set -euo pipefail
cd "$(dirname "$0")/.."

if grep -q '^\s*build_runner:' pubspec.yaml; then
  dart run build_runner build -d
fi
python3 tool/embed_rules.py --check
dart format --set-exit-if-changed .
dart analyze --fatal-infos --fatal-warnings
# Purity gate: the core must never import Flutter, Serverpod or dart:io.
if grep -rnE "package:(flutter|serverpod)|dart:(io|ui)" lib; then
  echo "med_core must stay pure (no Flutter/Serverpod/dart:io imports)" >&2
  exit 1
fi
dart test
