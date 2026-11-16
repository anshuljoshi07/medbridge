# MedBridge — agent rules
- Source of truth: implementation.md (Part A = spec, Part B = ordered build steps).
- Before each step, load the skills listed for it in "Skills to load per step".
- House rules: flutter-conventions-index. Precedence: implementation.md > house-rule skills > dart-flutter plugin skills.
- After each step: run its "Done when" checks + tool/check.sh. Never continue on red.
- Synthetic data only. Never commit secrets (config/passwords.yaml, .env, service-account JSON are git-ignored).
- HUMAN-only: creating accounts, API keys, signing certificates, store submissions, real-device camera tests, clinical sign-offs. Stop and ask.
- Medical safety: never compute doses; never weaken the A8.2 rule table or the A8.4 invariants to make a test pass.
- Use the Dart MCP server for analysis, tests, hot reload and screenshots instead of guessing.
