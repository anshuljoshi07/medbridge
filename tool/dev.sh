#!/usr/bin/env bash
# Starts MedBridge locally or in a GitHub Codespace:
#   server (embedded Postgres, no Docker) + seed data + patient web app.
# Usage: tool/dev.sh            → app at http://localhost:8100
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
export PATH="$PATH:$HOME/.pub-cache/bin:$HOME/flutter/bin"
SERVER="$ROOT/medbridge/medbridge_server"
APP="$ROOT/medbridge/medbridge_flutter"

"$SERVER/tool/gen_passwords.sh"
(cd "$ROOT/medbridge" && flutter pub get >/dev/null)

echo "Seeding synthetic data (idempotent)…"
(cd "$SERVER" && dart run bin/seed.dart --with-scans)

echo "Starting server on :8080…"
(cd "$SERVER" && dart run bin/main.dart --apply-migrations > "$ROOT/.server.log" 2>&1) &
SERVER_PID=$!
trap 'kill $SERVER_PID 2>/dev/null || true' EXIT
for _ in $(seq 1 90); do curl -s -o /dev/null http://localhost:8080/ && break; sleep 2; done

API_URL="http://localhost:8080/"
if [ -n "${CODESPACE_NAME:-}" ]; then
  API_URL="https://${CODESPACE_NAME}-8080.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}/"
  # The browser app calls the API cross-origin, so the API port must be public.
  gh codespace ports visibility 8080:public -c "$CODESPACE_NAME" || \
    echo "⚠ Make port 8080 public in the Ports tab."
fi
echo "API: $API_URL   (server log: .server.log)"
echo "Login: rdoe@medbridge.test  code 123456   — see README for all roles"

cd "$APP"
flutter run -d web-server --web-hostname 0.0.0.0 --web-port 8100 \
  --dart-define=SERVER_URL="$API_URL"
