# MedBridge — *Discharge meds, made clear*

A tool to streamline medication reconciliation after hospital discharge.
Patients scan their discharge papers and their pill bottles; MedBridge tells
them, one bottle at a time, whether to **continue, change, stop, start, hold**
— and flags duplicates and anything not on the plan for the care team.

Carle Illinois College of Medicine × Gies College of Business capstone.

> ⚠️ **Synthetic data only.** Nothing in this repository or any environment
> built from it may contain real patient data. MedBridge displays the
> clinician's plan and routes questions; it does not direct therapy. See the
> pilot gate in [`implementation.md`](implementation.md) (B12) before any real use.

**→ [Feature guide: what works today](FEATURES.md)**

## Try it

| Where | How |
|---|---|
| **GitHub Codespaces** (runs everything) | [![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/anshuljoshi07/medbridge) → wait for setup (~10 min the first time) → run `tool/dev.sh` → open forwarded port **8100** |
| **On your Mac** | Install Flutter (stable) and `dart pub global activate serverpod_cli`, then run `tool/dev.sh` → <http://localhost:8100> |
| **GitHub Pages** (web app only) | <https://anshuljoshi07.github.io/medbridge/> — needs a running server; set the repo variable `MEDBRIDGE_API_URL` (see [`.github/workflows/pages.yml`](.github/workflows/pages.yml)) |

No Docker is needed: the server uses Serverpod's embedded PostgreSQL in
development. `tool/dev.sh` creates local secrets, seeds the test data, starts
the server on `:8080` and the patient app on `:8100`.

## Test logins

In **development** every account signs in with the same one-time code:

### OTP code: `123456`

| Email | Role | What you'll see |
|---|---|---|
| `rdoe@medbridge.test` | Patient — **R. Doe, 78** | Full B10 scenario: plan with 5 changes, 7 bottles already scanned (3 red results, 4 auto-questions). |
| `jsmith@medbridge.test` | Patient — **J. Smith, 71** | A second plan (incl. warfarin, high-risk). No care team yet — link one with the invite codes below. |
| `caregiver@medbridge.test` | Caregiver | Linked to R. Doe: read-only view of plan, results, schedule and questions. |
| `pharmacist@medbridge.test` | Pharmacist | Linked to R. Doe. Can verify/edit plans and answer questions (dashboard not built yet; API ready). |
| `clinician@medbridge.test` | Clinician | Linked to R. Doe. Read + answer only. |
| `pcp@medbridge.test` | PCP | Linked to R. Doe. Read-only summary + answer. |
| `admin@medbridge.test` | Admin | Creates clinician accounts (`dart run bin/admin.dart`). |

Any other email (e.g. `you@medbridge.test`) also works with `123456` and
creates a fresh account — onboarding then asks if you're a patient or a
caregiver.

> Staging/production never use the fixed code: they send random codes by email.

## Test invite codes

Invites are **patient-initiated** and **single-use**.

| Code | Role | Links to | Accept with |
|---|---|---|---|
| `CARE2345` | Caregiver | J. Smith | Any new account → onboarding "I help someone" → enter code |
| `RDCG2345` | Caregiver | R. Doe | Any new account → "I help someone" → enter code |
| `PHRM2345` | Pharmacist | J. Smith | `pharmacist@medbridge.test` → Care team → enter code |
| `DCTR2345` | Clinician | J. Smith | `clinician@medbridge.test` → Care team → enter code |
| `PCPD2345` | PCP | J. Smith | `pcp@medbridge.test` → Care team → enter code |

Clinical codes only work for an account with the matching role (clinician
accounts are created by an admin, never self-served).

Used them up? Make them pending again:

```bash
cd medbridge/medbridge_server
dart run bin/seed.dart --reset-invites     # stop the server first
```

Patients can also create new codes in the app: **Care team → Invite**.

## Walkthrough (R. Doe)

1. Sign in as `rdoe@medbridge.test`, code `123456`; finish onboarding.
2. **Today** shows the *Needs attention* card, next dose and reminders
   (losartan, metoprolol, atorvastatin — never the stopped or held meds).
3. **Scan → Scan bottle** → pick a sample bottle (the browser build has no
   camera; you can also type label text). Expected results:

   | Bottle | Result |
   |---|---|
   | lisinopril 10 mg | **Stop** (red) |
   | losartan 50 mg | **New** |
   | metoprolol succinate ER 50 mg | **Changed** — old strength, don't use (red) |
   | atorvastatin 40 mg | **Continue** |
   | metformin 500 mg | look-alike choice → **Hold** |
   | benazepril 20 mg (not on papers) | **Duplicate** of losartan (red) |
   | omeprazole 20 mg (not on papers) | **Unknown** — not on plan |

4. **Questions** has auto-added questions; **Share with my doctor** makes the PDF.
5. **Scan → Scan discharge papers → Use the sample papers** to re-run plan capture.

## What's in the repo

```
implementation.md           the spec (Part A) and build plan (Part B)
docs/progress.md            build log, decisions, what's left
tool/dev.sh                 one command to run everything
medbridge/
  packages/med_core/        pure Dart: NDC, sig parser, AVS/label parsers,
                            reconciliation rules (A8.2) + safety checks
    rules/*.json            versioned rule files (placeholder rows marked "test": true)
  packages/med_ui/          design system: themes, Atkinson Hyperlegible, EN/ES, widgets
  medbridge_server/         Serverpod API, models, alerts, seed + admin CLI
  medbridge_client/         generated client (do not edit)
  medbridge_flutter/        patient + caregiver app (Chrome today; iOS/Android later)
  medbridge_dashboard/      clinician dashboard (not built yet)
```

## Tests

```bash
cd medbridge/packages/med_core && ./tool/check.sh     # 1,470 tests: rules, parsers, B10 scenario
cd medbridge/packages/med_ui && flutter test           # 48 tests: contrast, layouts at 200% text
cd medbridge/medbridge_server && dart test             # 16 tests: B10 end to end + authorization
```

## Status

Done: core rules and parsers, server, design system, patient web app (first
version). Not yet: clinician dashboard, phone camera/OCR, reminders/push,
eval tooling, CI. Accounts and sign-offs still needed (Firebase, Google OAuth,
SMTP, rule-list licensing, pharmacist and translator review) are listed in
[`docs/progress.md`](docs/progress.md).
