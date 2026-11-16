#!/usr/bin/env bash
# CI gate for medbridge_server (B1/B5): generate → format → analyze → tests.
set -euo pipefail
cd "$(dirname "$0")/.."
export PATH="$PATH:$HOME/.pub-cache/bin"
serverpod generate
# Generated code is excluded from the format check.
dart format --set-exit-if-changed lib/src/core lib/src/endpoints lib/src/services \
  lib/src/future_calls lib/src/seed lib/src/pod_setup.dart lib/server.dart bin test/integration/support \
  test/integration/golden_scenario_test.dart
dart analyze --fatal-infos --fatal-warnings
dart test
