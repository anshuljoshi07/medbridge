# MedBridge — *Discharge meds, made clear*
### Implementation spec (single-pass build)

> A tool to streamline medication reconciliation after hospital discharge.
> Carle Illinois College of Medicine × Gies College of Business capstone.
> Dev: Neo (solo). Clinical/business team: Anvita Mishra, Gaurang Amonkar, Peter Kim, Abraham Verdoes, Maria Frolova.

## How to use this file
- **Part A** is the spec (what to build).
- **Part B** is the build (how), as ordered steps. Execute B-1 → B12 top to bottom.
- Every step lists files, commands and a **Done when** check. Don't start a step until the previous step's checks pass.
- **Synthetic data only.** No real patient data touches any environment built from this file (see A11).
- If a step conflicts with Part A, Part A wins. Fix the step.

### Quick start: run this file

**1. One-time machine setup**
- Flutter stable (Dart ≥ 3.9) with `flutter doctor` clean.
- Xcode (Mac only, needed for iOS) and Android Studio.
- Docker Desktop, running.
- Serverpod CLI: `dart pub global activate serverpod_cli`
- Claude Code: `brew install --cask claude-code` on Mac; other systems see https://code.claude.com/docs/en/quickstart. Then run `claude` once and `/login`.

**2. Make the repo**
```bash
mkdir medbridge-app && cd medbridge-app
git init
# copy implementation.md into this folder
```
Don't name the folder `medbridge`. B1 runs `serverpod create medbridge`, which creates its own `medbridge/` folder.

**3. Install agent tooling (B-1, from your terminal)**
```bash
claude plugin marketplace add flutter/agent-plugins
claude plugin install dart-flutter@dart-flutter
claude mcp add --transport stdio dart -- dart mcp-server
claude mcp list          # should show "dart"
```
Then enable the **Flutter Skills** plugin on claude.ai (house rules). Design and Mobile App Design (iOS) are optional.

**4. Gather the HUMAN items first (B0)** so the agent doesn't stall:
- **Firebase project:** enable Phone + Google sign-in, add fictional test phone numbers, download the service-account JSON, enable FCM.
- **Google OAuth client IDs** for iOS, Android and web.
- **SMTP credentials** for email OTP.

Keep these outside the repo. The agent asks for them and writes them to the git-ignored `config/passwords.yaml`.

**5. Start Claude Code at the repo root** (`claude`) **and paste the kickoff prompt below.**

**6. While it runs**
- Approve commands when asked.
- Watch `docs/progress.md`.
- Answer HUMAN pauses as they come up.
- If the session ends or runs out of context: `claude --continue`, then paste the resume prompt below.

**7. Run it yourself (B11)**
```bash
cd medbridge/medbridge_server && docker compose up -d && dart bin/main.dart --apply-migrations && dart run bin/seed.dart
cd ../medbridge_flutter && flutter run          # phone plugged in
cd ../medbridge_dashboard && flutter run -d chrome
```

**8. Test on a real phone.** Print the synthetic AVS and label fixtures from `tools/synth_avs`, scan them, and confirm the 7 expected results from B10. Tune the OCR confidence thresholds in `rules/config.json` here.

**9. Before any real patient:** complete the pilot gate in B12.

### Kickoff prompt (paste into Claude Code at the repo root)
```
Read implementation.md end to end. Then do step B-1: the dart-flutter plugin and Dart MCP server
are already installed from my terminal, so just verify them, confirm you can see the house-rule
skills, and write CLAUDE.md and .gitignore. Then execute Part B (B0 → B12) in order.
Load the skills listed for each step before starting it. After each step, run its "Done when"
checks and tool/check.sh, and fix until green before moving on. Log progress in docs/progress.md.
Pause and ask me only for items marked HUMAN (accounts, secrets, real-device testing, sign-offs).
```
**Resume prompt** (new session, after `claude --continue` or a fresh `claude`):
```
Read CLAUDE.md, implementation.md and docs/progress.md, then continue Part B from the last unfinished step.
```

### Skills to load per step
| Step | Skills |
|---|---|
| All | `flutter-conventions-index` (house rules), `naming-conventions`, `dartdoc-conventions` |
| B1 Scaffold | `project-structure-and-packages`, `lint-and-style-config`, `codegen-and-toolchain`, `dependency-hygiene` |
| B2–B4 `med_core` | `dart3-idioms-and-coding-standards`, `error-handling-typed-results`, `value-objects-money-and-units`, `seeded-determinism-and-golden-vectors`, `testing-strategy` |
| B5 Server | `async-safety`, `error-handling-typed-results` (no Serverpod skill exists, so follow the Serverpod docs) |
| B6 `med_ui` | `design-system-structure`, `accessibility-as-code`, `i18n-rtl-l10n`, `motion-and-haptics`, `widget-golden-and-a11y-testing` |
| B7 App | `scaffold-feature-module`, `flutter-architecture`, `app-startup-and-bootstrap`, `state-management-riverpod`, `widget-composition`, `navigation-and-routing`, `forms-and-input`, `ui-states-and-feedback`, `persistence-drift`, `run-migration`, `service-boundary-and-native`, `local-notifications-scheduler`, `data-export-and-restore`, `flutter-performance`, `run-codegen` |
| B8 Dashboard | `adaptive-layout`, `navigation-and-routing`, `ui-states-and-feedback` |
| B10 CI | `ci-pipeline-and-gates`, `run-goldens-rebaseline` |
| B12 | `design-review-workflow`, `release-and-store-shipping` |
| Not needed | `ads-and-iap-monetization`, `custom-canvas-and-gestures` |

Use the official **dart-flutter** plugin skills (installed in B-1) for tasks the house rules don't cover: testing helpers, static analysis, layout fixes, runtime-error debugging. **Precedence on conflict:** implementation.md > house-rule skills (`flutter-conventions-index` family) > dart-flutter plugin skills.

---

# PART A — SPEC

## A1. Decisions

| Area | Decision |
|---|---|
| Mobile app | **Flutter** (iOS + Android): patient + caregiver |
| Clinician UI | **Flutter web** dashboard: pharmacist / clinician / PCP |
| Backend | **Serverpod** (Dart) + Postgres (+ Redis) |
| Discharge plan source | **Scan the paper discharge summary (AVS)** |
| OCR / parsing | **ML Kit text recognition + deterministic rules** (no LLM) |
| Drug codes | **RxNorm RxCUI + NDC**; RxClass (ATC) used as a **lookup** for class checks |
| Sig notation | **Standard abbreviations**; everything else is **detected and routed to "ask"** |
| Statuses | Continue · Changed · Stop · New · Hold · Duplicate class · Unknown |
| Safety checks | Look-alike/sound-alike · high-risk flags · drug–drug interactions · allergy |
| Sign-in | Email OTP, Google, phone OTP (Firebase) |
| Extras | Caregiver alerts, read-aloud (TTS), Spanish UI |
| Later (not built here) | Epic FHIR, pill photo ID, on-device LLM, tapers / non-daily sigs |
| Hosting / PHI | Deferred → **synthetic data only** |

**Gaps in the decisions, resolved here:**
1. The "Duplicate class" status needs class data, so RxClass is a lookup dependency, not a stored code.
2. Only standard sigs are supported, so tapers, weekly and complex dosing are **detected and refused**, never guessed. A weekly drug misread as daily is a classic fatal error.

## A2. Problem (from the MedBridge deck)
- **Observation:** patients are often discharged with multiple, complex medication changes.
- **Incident:** an elderly patient took **both old and new blood-pressure meds** because the bottles looked alike → fall, hip fracture, readmission.
- **Root problem:** discharge paperwork is long, overwhelming and hard to navigate.
- **Evidence:**
  - Polypharmacy (≥5 meds) affects >40% of US adults ≥65; prevalence rose 8.2% → 17.1% (1999–2018) (Harris, *JAMA* 2024).
  - 24% of medication changes are not followed within 30 days (Weir, *Am J Med* 2019).
  - 81% of patients have ≥1 discrepancy after discharge (Armor, *J Pharm Pract* 2016).
- **Problem statement:** recently discharged patients and caregivers need to clearly understand medication changes at home, to reduce medication errors, anxiety and preventable complications.
- **Why existing tools fall short:**
  - Printed education: overload, poor retention.
  - Portals: hard to navigate, need digital literacy.
  - Reminder apps: assume the list is correct.
  - Pharmacist reconciliation: effective but resource-intensive.
  - PCP follow-up: comes days to weeks later.

## A3. Users and roles
| Role | Can | Cannot |
|---|---|---|
| Patient | Scan AVS + bottles, confirm plan, log doses, ask questions, invite care team | — |
| Caregiver | View plan / results / schedule, add questions, receive alerts | Edit plan |
| Pharmacist | Verify / edit extracted plan, review flags, answer questions | See unlinked patients |
| Clinician / PCP | View summary, flags, Q&A; answer questions | Edit plan; see unlinked patients |

Linking is **patient-initiated** (invite code). Clinician accounts are created by an admin.

## A4. Scope
**In:**
- Auth and onboarding.
- AVS capture → plan.
- Bottle scan → reconcile → action cards.
- Daily schedule + reminders + adherence log.
- Q&A list + PDF export.
- Caregiver linking + alerts.
- TTS, EN/ES.
- Clinician dashboard, safety checks.
- Synthetic data tools + eval harness.
- Local and free dev deploy.

**Out:**
- Prescribing or dose arithmetic; editing therapy.
- Epic / FHIR, pill ID, LLMs.
- Tapers, weekly, sliding-scale, half-tab or liquid-volume dosing support (these are detection only).
- Real PHI.

## A5. Features and acceptance criteria

**F1 Sign-in and onboarding**
- **Methods:**
  - Email OTP (Serverpod `EmailOtpIdpBaseEndpoint`).
  - Google (Serverpod Google IdP).
  - Phone OTP (Serverpod Firebase IdP → Firebase phone auth).
- **Onboarding:** language → role → text-size preview → notification permission → allergies (optional).
- **AC:**
  - All three methods work on iOS and Android.
  - Phone OTP uses Firebase **fictional test numbers** in dev (real SMS needs the Blaze plan).
  - Sign-out wipes tokens and locks the local DB.

**F2 Discharge plan capture**
- **Flow:** doc-scan pages → OCR → AVS parser (A7.1) → review screen (each item shows action, drug, strength, sig and **source line**) → patient confirms/edits → plan `unverified` → pharmacist may verify (badge).
- **AC:**
  - Low-confidence items must be confirmed.
  - Unparseable lines appear under "Unrecognized" and are never dropped.
  - Unsupported sigs are labeled "Ask your pharmacist".

**F3 Bottle scan**
- **Flow:** barcode first (NDC) → else multi-frame OCR while the user rotates the bottle → label parser (A7.2) → RxCUI → **confirm screen** → reconcile.
- **AC:**
  - **No images stored.**
  - A confirm screen always appears before a status.
  - Confidence < floor → Unknown.
  - Barcode path < 2 s; OCR path < 8 s on a mid-range phone.

**F4 Reconcile + action cards**
- **Card contents:**
  - Status
  - Plain-language instruction (EN/ES)
  - Plan source line
  - Severity shown with color + icon + text
  - Read-aloud button
  - "Add question" button
- **Plan checklist:** shows `New`/`Changed` plan items with no bottle scanned ("Pick up from pharmacy").
- **AC:**
  - Every rule row (A8.2) is unit-tested.
  - Red results auto-create a Question + dashboard flag.

**F5 Schedule, reminders, adherence**
- Slots: morning / noon / evening / bedtime, from the parsed sig.
- PRN shows "as needed, max N/day" and gets no reminders.
- Taken / Skip logging.
- Missed = not logged within 2 h (configurable).
- **AC:**
  - Reminders survive reboot and time-zone change.
  - Stop / Hold suspends reminders immediately; Hold resumes on its date after confirmation.

**F6 Q&A list**
- **Auto items from:** Unknown, Duplicate, Stop, red Changed, DDI, allergy, unsupported sig.
- **Patient / caregiver items:** free text.
- **Export:** one-page PDF (plan + discrepancies + questions) for the PCP visit.
- **AC:** auto items link to their source; clinicians can answer.

**F7 Caregiver linking + alerts**
- Invite code / deep link; the patient can revoke.
- **Alert triggers:** red result; N consecutive missed doses (default 2); a missed high-risk med.
- **AC:** push text contains **no PHI** ("MedBridge: please check on {firstName}'s medications"); every alert is logged.

**F8 Read-aloud**
- Uses platform TTS; reads plain-language templates, never abbreviations.
- Pronunciation override map for drug names.
- **AC:** works offline; respects the system speech rate.

**F9 Spanish UI**
- ARB `en`/`es` for all UI.
- Sig output from **templates** (A6.6), never machine translation; drug names unchanged.
- **AC:** layouts pass at 200% text scale in both languages; templates are flagged "pending translator review".

**F10 Clinician dashboard (Flutter web)**
- **Views:**
  - Patient list (red/amber counts)
  - Plan verification (source lines ↔ items, edit, verify)
  - Flagged scans
  - Q&A inbox
  - PCP summary (read-only)
- **AC:**
  - Role-based access; only linked patients are visible.
  - Every PHI view is audit-logged.
  - Idle timeout 15 min; cookie-based auth on web.

**F11 Safety checks:** see A8.3. These run on every reconcile and every plan change.

## A6. Medical notation

### A6.1 RxNorm term types
| TTY | Meaning | Example | Use |
|---|---|---|---|
| `IN` / `MIN` | ingredient / multi-ingredient | lisinopril | **primary match key** |
| `SCDC` | ingredient + strength | lisinopril 10 MG | strength diff |
| `SCDF` | ingredient + form | lisinopril Oral Tablet | form diff |
| `SCD` | ingredient + strength + form | lisinopril 10 MG Oral Tablet | **exact match key** |
| `SBD` | branded drug | Zestril 10 MG Oral Tablet | map → SCD |
| `BN` | brand name | Zestril | OCR lexicon |

Match ladder: ingredients equal? → SCD equal? → if not, explain using SCDC (strength) / SCDF (form).

### A6.2 NDC
- **Formats:**
  - 10-digit, three segment shapes: `4-4-2`, `5-3-2`, `5-4-1`.
  - Normalize to 11-digit `5-4-2` by zero-padding the short segment.
- **Ambiguity:**
  - A hyphen-less 10-digit NDC → generate all 3 candidates.
  - Keep those that resolve via RxNorm (`/rxcui.json?idtype=NDC&id=`).
  - More than 1 resolves → Unknown + confirm.
- **UPC-A barcode (12 digits)** = `3` + 10-digit NDC + check digit → strip both ends → candidates as above.
- **GS1 DataMatrix:** the GTIN embeds the NDC → extract the 10 digits → candidates.
- **Pharmacy-label barcodes** are often internal Rx numbers. If one doesn't resolve, ignore it and fall back to OCR.

### A6.3 Forms, release, units
- **Release:** same ingredient + strength with a different release (IR vs ER/XR/SR/CR/DR/LA) is **not** a match → `FORM_MISMATCH`.
- **Forms:** tablet, capsule, ODT, solution / suspension, inhaler, patch, cream / ointment, eye / ear drops, injection pen.
- **Units:** mg, mcg, g, mL, units, mEq, %.
  - Display `mcg`, never `µg`; display `units`, never `U`.
  - Unit conversion is **for comparison only** (1000 mcg = 1 mg), never for dosing output.

### A6.4 Sig: supported abbreviations
| Token(s) | Normalized |
|---|---|
| `PO` | route=oral |
| `SL` | route=sublingual |
| `INH` | route=inhalation |
| `TOP` | route=topical |
| `TD` | route=transdermal |
| `SC`, `SQ`, `subcut` | route=subcutaneous |
| `OD` / `OS` / `OU` | route=ophthalmic, side=right / left / both |
| `QD`, `daily`, `once daily` | timesPerDay=1 |
| `BID` | timesPerDay=2 |
| `TID` | timesPerDay=3 |
| `QID` | timesPerDay=4 |
| `QAM` / `QPM` | slot=morning / evening |
| `QHS`, `HS`, `at bedtime` | slot=bedtime |
| `q4h` `q6h` `q8h` `q12h` | intervalHours=N |
| `PRN`, `as needed` | prn=true (+ `max N/day`) |
| `AC` / `PC` | withFood=before / after |
| `tab` `cap` `gtt` `puff` | doseUnit |

Grammar:
```
SIG  := VERB? QTY UNIT? ROUTE? FREQ (PRN MAX?)? FOOD? DURATION?
VERB := take|inhale|apply|instill|inject|place|use
QTY  := int | word-number ("one".."four")
```
Default slot mapping:
- 1×/day → morning
- 2× → morning, evening
- 3× → morning, noon, evening
- 4× → morning, noon, evening, bedtime
- q12h → morning, evening
- q8h → morning, afternoon, bedtime
- q6h → 4 slots

### A6.5 Sig: detected but unsupported → status Unknown, reason `SIG_UNSUPPORTED:{flag}`
| Flag | Triggers |
|---|---|
| `TAPER` | "then", "decrease", "taper", multiple dose blocks, "for N days then" |
| `NON_DAILY` | weekly, "once a week", weekday names, "every other day", `QOD` |
| `SLIDING_SCALE` | "sliding scale", "per scale", "units based on" |
| `HALF_TAB` | `1/2`, `½`, "half" |
| `LIQUID_VOLUME` | dose in mL / tsp / tbsp |
| `RANGE_DOSE` | "1-2", "1 to 2", "2–3" |

**Error-prone notation** (Joint Commission "Do Not Use" + ISMP):
- **Parse** these because labels still contain them: `QD`, `QOD`, `U`, `IU`, `MS`/`MSO4`/`MgSO4`, trailing zero (`1.0 mg`), missing leading zero (`.5 mg`).
- **Never display** them.
- A trailing or missing leading zero raises **`ZERO_RISK`** and forces confirmation (10× error risk).

### A6.6 Plain-language templates (ES = draft pending medical-translator review)
| Key | EN | ES |
|---|---|---|
| `freq.1` | once a day | una vez al día |
| `freq.n` | {n} times a day | {n} veces al día |
| `every.h` | every {h} hours | cada {h} horas |
| `slot.morning` | every morning | cada mañana |
| `slot.evening` | every evening | cada noche |
| `slot.bedtime` | at bedtime | al acostarse |
| `prn` | only if needed | solo si es necesario |
| `prn.max` | no more than {n} a day | no más de {n} al día |
| `route.oral` | by mouth | por la boca |
| `food.before` | before meals | antes de las comidas |
| `food.after` | after meals | después de las comidas |

Example: `Take 1 tab PO BID PC` → "Take 1 tablet by mouth 2 times a day, after meals."

## A7. Parsing pipelines

### A7.1 AVS parser
1. Input: OCR lines with bounding boxes, in page/reading order.
2. **Section detection** from `rules/avs_headers.json`. Common Epic patterns are *START taking*, *CHANGE how you take*, *CONTINUE taking*, *STOP taking*, plus allergy headers. The header sets the `action`. Confirm against real Carle samples (Q1).
3. **Line grammar:** `DRUG STRENGTH FORM`, then the sig on the same or next line, then optional "Commonly known as: BRAND".
4. **Name resolution:** on-device lexicon fuzzy match → server `rx.approximate` → RxCUI.
5. **Output:** `PlanDraft { items[], unrecognized[], allergies[] }`, each item with `sourceLine` + `confidence`.

### A7.2 Bottle label parser
1. **Barcode** → NDC candidates → RxCUI (fast path).
2. **Multi-frame OCR:** OCR every 3rd frame over ~3 s of rotation. Tokens are merged by **majority vote**, independent of position (this handles curvature without dewarping).
3. **Field extraction:**
   - Drug: lexicon match.
   - Strength: `\d+(\.\d+)?\s?(mg|mcg|g|mL|units|%)`.
   - Sig: line starting with a verb.
   - Qty / refills / fill date / prescriber / pharmacy: anchor words.
4. **Closed-set boost:** score candidates against the patient's plan (old + new meds) first.
5. **LASA gate:** if the top-2 candidates form a pair in `rules/lasa_pairs.json`, or their scores are within δ = 0.05, show a forced choice screen with both names.

### A7.3 Confidence
- `conf = min(nameScore, strengthScore)`.
- **Penalties:** `ZERO_RISK` −0.2, missing strength −0.3, single-frame read −0.1.
- **Bands:**
  - ≥ 0.90: pre-filled confirm.
  - 0.70–0.90: confirm with field highlighted.
  - < 0.70: Unknown (`LOW_CONFIDENCE`).
- All values live in `rules/config.json`.

## A8. Reconciliation engine

### A8.1 Contract
```dart
ReconResult reconcile(Plan p, Scan s, RuleSet r);
```
- **Pure, total, deterministic.** No I/O; class data is prefetched into `Scan`.
- Runs on device (offline) **and** server (authoritative), using the same `ruleVersion`.
- Enum names avoid Dart keywords:
  - `PlanAction { keep, change, stop, start, hold }`
  - `ReconStatus { keep, changed, stop, newMed, hold, duplicate, unknown }`
- UI labels: Continue / Changed / Stop / New / Hold / Duplicate / Unknown.

### A8.2 Rule table (top to bottom, first match wins)
| # | Condition | Status | Sev | Reason | Patient sees (EN) |
|---|---|---|---|---|---|
| 0 | not confirmed or conf < floor | unknown | amber | `LOW_CONFIDENCE` | "We couldn't read this clearly. Add it to your questions." |
| 1 | ingredient match, action=stop | stop | red | `PLAN_STOP` | "Your care team stopped this medicine. Don't take it. Set it aside." |
| 2 | ingredient match, action=hold | hold | amber | `PLAN_HOLD` | "Pause this medicine until {date/condition}." |
| 3 | ingredient match, action=change, SCD = plan SCD | changed | amber | `NEW_DIRECTIONS` | "Same medicine, **new directions**: {sig}." |
| 4 | ingredient match, action=change, SCD ≠ plan SCD | changed | red | `OLD_STRENGTH_BOTTLE` | "Your dose changed. **Don't use this bottle** until a pharmacist confirms." |
| 5 | ingredient match, action=keep, SCD equal | keep | ok | `MATCH` | "Keep taking this as before: {sig}." |
| 6 | ingredient match, action=keep, strength/form differs | changed | red | `STRENGTH_MISMATCH` / `FORM_MISMATCH` | "This bottle doesn't match your plan. Ask your pharmacist before taking." |
| 7 | ingredient match, action=start, SCD equal | newMed | info | `NEW_MED` | "This is a **new** medicine: {sig}." |
| 8 | ingredient match, action=start, SCD differs | changed | red | `NEW_MED_MISMATCH` | "This doesn't match the new medicine on your plan. Ask your pharmacist." |
| 9 | no ingredient match; shares a **class group** with an active plan item (keep/change/start) | duplicate | red | `SAME_CLASS_AS:{itemId}` | "This may do the **same job** as {plan med}. Don't take both. Ask your care team." |
| 10 | otherwise | unknown | amber (red if high-risk) | `NOT_ON_PLAN` | "This isn't on your discharge plan. Ask before taking it." |

- **Combination products:**
  - Ingredient match = any overlap.
  - Partial overlap → `changed`, red, `COMBO_PARTIAL`.
- **Class groups (row 9):**
  - Same ATC level-4 class **or** same pharmacist-curated group in `rules/class_groups.json`.
  - Groups matter: the deck's case is likely ACE-I ↔ ARB, which are **different** ATC-4 classes (C09AA vs C09CA) but the same clinical job.
- **Row 9 is the deck's incident.** It fires even when the old bottle was left off the AVS.

### A8.3 Safety overlays (can raise severity, never lower it)
| Check | Data | Effect |
|---|---|---|
| Look-alike / sound-alike | `rules/lasa_pairs.json` (ISMP confused-names list, pharmacist-curated) | Forced choice at scan time; badge |
| High-risk | `rules/high_risk.json` (ISMP high-alert meds, community/ambulatory; AGS Beers for ≥65) | Badge; unknown/missed → red; dashboard flag |
| Drug–drug interaction | `rules/ddi_pairs.json`: curated from the published *high-priority DDIs for EHRs* list. NLM's RxNav interaction API was discontinued in Jan 2024 | Banner + auto Question; never "stop" advice |
| Allergy | Patient allergies → ingredient / class | Red block + alert |

Licensing for ISMP / Beers / any DDI source must be confirmed before shipping (Q6). The repo ships **placeholder rows clearly marked `"test": true`**.

### A8.4 Invariants (property tests)
1. Total: every (plan, scan) → exactly one status + reason.
2. No `keep` when conf < floor.
3. Never outputs a computed dose.
4. `stop`, `duplicate`, red `changed`, and allergy hits always create a Question + flag.
5. Deterministic: same inputs + `ruleVersion` → same output on device and server.
6. Overlays never lower severity.

## A9. Data model

### A9.1 `med_core` domain types (freezed)
| Type | Fields |
|---|---|
| `Plan` | `id, items, allergies, verified` |
| `PlanItem` | `id, action, name, rxcui?, ings:Set<String>, scd?, strength, form, route, sigRaw, sig?, holdUntil?, src, conf` |
| `ParsedSig` | `qty, unit, route, perDay?, everyH?, slots, prn, prnMax?, food?, days?, flags:Set<SigFlag>, conf` |
| `Scan` | `ndc11?, rxcui?, ings, scd?, strength, form, sigRaw, sig?, conf, confirmed, classIds:Set<String>, groupIds:Set<String>` |
| `ReconResult` | `status, reason, sev, itemId?, flags:List<SafetyFlag>, ruleVersion` |
| `RuleSet` | `version, lasa, highRisk, ddi, groups, config` |

### A9.2 Server (Serverpod `*.spy.yaml`), adapters `toCore()` / `fromCore()`
| Model | Fields |
|---|---|
| `Patient` | userId, lang, birthYear?, allergiesJson |
| `CareLink` | patientId, userId, role, status, inviteCode, createdAt |
| `DischargePlan` | patientId, source, dischargeDate?, status (`draft`/`unverified`/`verified`), verifiedBy?, verifiedAt? |
| `PlanItemRow` | planId, action, name, rxcui?, ingsJson, scd?, strength, form, route, sigRaw, sigJson?, holdUntil?, src, conf |
| `BottleScan` | patientId, ndc11?, rxcui?, ingsJson, strength, form, sigRaw, sigJson?, ocrText, conf, confirmed, scannedAt |
| `ReconRow` | scanId, planItemId?, status, reason, sev, flagsJson, ruleVersion, createdAt |
| `DoseSchedule` | planItemId, slotsJson, prn, active, suspendedUntil? |
| `DoseEvent` | scheduleId, dueAt, state (`taken`/`skipped`/`missed`), loggedAt? |
| `Question` | patientId, text, source, linkedReconId?, status, answer?, answeredBy? |
| `Alert` | patientId, type, sev, recipientsJson, sentAt, ackAt? |
| `AuditLog` | actorUserId, action, entity, entityId, at |
| `RxCache` | key (ndc / rxcui / term), kind, json, fetchedAt |

Example:
```yaml
# medbridge_server/lib/src/models/plan_item_row.spy.yaml
class: PlanItemRow
table: plan_item
fields:
  planId: int
  action: String       # keep|change|stop|start|hold
  name: String
  rxcui: String?
  ingsJson: String
  strength: String
  form: String
  sigRaw: String
  sigJson: String?
  holdUntil: DateTime?
  src: String
  conf: double
```

### A9.3 Device (drift + SQLCipher)
- Tables mirror the patient-side models, plus `SyncOutbox(id, op, payloadJson, createdAt, tries)`.
- The DB key lives in `flutter_secure_storage`.
- The app is fully usable offline.

### A9.4 Rule files (`packages/med_core/rules/`, versioned)
| File | Shape |
|---|---|
| `config.json` | `{version, confFloor:0.7, confHigh:0.9, lasaDelta:0.05, missedWindowMin:120, missedAlertN:2}` |
| `sig_abbrev.json` | `{token: {field, value}}` |
| `avs_headers.json` | `{start:[..], change:[..], keep:[..], stop:[..], hold:[..], allergies:[..]}` |
| `lasa_pairs.json` | `[{a:"hydroxyzine", b:"hydralazine"}, {a:"metformin", b:"metronidazole"}]` + `"test":true` until pharmacist-curated |
| `high_risk.json` | `[{ing:"warfarin"}, {ing:"insulin glargine"}, ...]` + `"test":true` |
| `ddi_pairs.json` | `[{a:"warfarin", b:"ibuprofen", sev:"major", msg:"bleeding risk"}]` + `"test":true` |
| `class_groups.json` | `{raas:["C09AA","C09CA","C09XA"], beta_blocker:["C07AA","C07AB"], statin:["C10AA"], ppi:["A02BC"], anticoag:["B01AA","B01AE","B01AF"], dhp_ccb:["C08CA"], thiazide:["C03AA"]}`. Groups need pharmacist sign-off (Q5) |

## A10. API (Serverpod endpoints, all `requireLogin`)
| Endpoint | Methods |
|---|---|
| auth | provided by `serverpod_auth_idp` (email OTP, Google, Firebase) |
| `patient` | `me`, `updatePrefs`, `setAllergies` |
| `plan` | `uploadDraft`, `confirm`, `get`, `verify`*, `editItem`* |
| `scan` | `submit(Scan) → ReconResult` (server re-runs reconcile), `history` |
| `rx` | `byNdc`, `approximate`, `classesFor`. RxNav proxy + `RxCache`, throttled ≤ 20 req/s |
| `schedule` | `get`, `logDose` |
| `questions` | `list`, `add`, `answer`* |
| `care` | `createInvite`, `acceptInvite`, `revoke`, `links` |
| `dashboard` | `patients`*, `flagged`*, `summary`* |
| `alerts` | `ack`; dispatcher = Serverpod future call every 15 min |

\* clinician roles only. Every method checks `CareLink` scope; every PHI read/write writes `AuditLog`.

## A11. Security, privacy, compliance
- **Data:** **synthetic data only** in every environment built from this file. Free hosting tiers don't sign BAAs.
- **Device:**
  - SQLCipher DB; key in Keychain / Keystore.
  - No images stored.
  - App-switcher snapshot blurred.
- **Transport and storage:** TLS only; encrypted server volumes; per-patient scoping on every query.
- **Notifications:** no PHI in push or notification text.
- **Before any real pilot:**
  - BAA hosting (AWS / GCP / Azure / Carle-hosted); auth providers' BAA status (Firebase phone/Google).
  - Carle IRB or QI determination.
  - Licensing for rule lists.
  - Pharmacist sign-off on A8.2 wording.
  - Medical-translator review of ES templates.
- **Regulatory:** MedBridge **displays the clinician's plan** and routes questions; it doesn't direct therapy. Run "don't take" wording past Carle compliance.

## A12. Metrics
- **Deck:**
  - 30-day readmissions tied to medication issues
  - Comprehension surveys (new / changed / stopped meds)
  - Phone queries to clinics within 14 days of discharge
- **Technical gates:**
  - Drug + strength accuracy on confirmed scans ≥ 95%
  - **Silent-wrong rate = 0** on the eval set
  - AVS item-level F1 ≥ 0.90
  - Scan-to-result < 2 s (barcode) / < 8 s (OCR)
  - SUS ≥ 70 with ≥5 adults 65+

## A13. UI & UX — "Calm, clear, one thing at a time"

### A13.1 Identity
- **App name:** MedBridge.
- **Tagline:** *"Discharge meds, made clear."* (ES draft: *"Sus medicinas del alta, claras."*)
- **App Store subtitle:** "Discharge meds, made clear" (26 of 30 chars).
- **Brand colors:** navy + teal from the deck logo, used for **chrome only** (app bar, primary buttons). Status colors are a separate palette and never reuse brand teal, so teal can't be misread as "OK".
- **Font:** **Atkinson Hyperlegible** (Braille Institute, free on Google Fonts). It's built for low vision, with distinct `I/l/1` and `O/0`. Use tabular figures for doses and times.
- **Type scale:**
  - Body 18 sp; headings 24 / 28.
  - Follows the system text scale, never clamped.
  - Light theme default; dark + high-contrast available.
- **Voice:**
  - Second person; sentences ≤ 15 words, verb first, ~6th-grade reading level.
  - Say "stop", not "discontinue". Never show abbreviations. Write numbers as digits.

### A13.2 Principles
1. **One decision per screen.**
2. **Every status = icon + word + color**, and red items sort first.
3. **Big targets:** primary buttons 56 dp tall and full width; every target ≥ 48 dp.
4. **Nothing gesture-only.** No swipe-to-act, no long-press.
5. **Undo beats "Are you sure?"** Taken/Skip gets a 5-second Undo. Exception: Stop and Duplicate need an explicit acknowledgment tap.
6. **Offline is normal.** No blocking spinners; show "Saved on this phone".
7. **Calm by default.** No red unless action is needed; no streaks or shame for missed doses.
8. **Contrast:** body ≥ 7:1 where reachable (4.5:1 floor), checked in both themes.

### A13.3 Navigation (mobile)
- **Bottom bar:** 4 labeled tabs (icon + text, always): **Today · Scan · My meds · Questions**. Scan is the raised center button.
- **Settings:** via the avatar in the app bar.
- **Caregiver mode:** persistent banner *"Viewing {Name}'s medicines"*, plus a switcher if they're linked to more than one patient.

### A13.4 Screens
| Screen | Key UI elements |
|---|---|
| **Onboarding** | Language first, with names in their own language ("English", "Español") · "Step 2 of 4" progress dots · text-size preview with a live sample card + slider · plain permission primers before OS prompts ("We use the camera only to read labels. Photos are never saved.") |
| **Today (home)** | Pinned **Needs attention** card when red results are unresolved ("2 medicines need attention → Review") · **Next dose** hero card (time, med, "1 tablet", Taken / Skip) · Morning / Noon / Evening / Bedtime sections with pill rows · "3 of 5 taken today" (text + ring) · empty state: *"Start by scanning your discharge papers"* + big button |
| **Scan papers** | Auto edge detection · page thumbnail strip · "Add page" · "Done" → review |
| **Review plan** | Grouped by chips: New · Changed · Keep taking · Paused · Stopped · each row shows its **source line** in a quote box · low-confidence fields outlined amber with "Check this" · big "Looks right" button · collapsible "Lines we couldn't read" |
| **Scan bottle** | Viewfinder with a bottle-outline guide · live hint *"Slowly turn the bottle"* · ring that fills as frames are read · haptic tick on lock · torch toggle · auto-switch to barcode when one is seen · "Type it instead" fallback |
| **Confirm** | Big name + strength, with **Tall Man lettering** for confusable names (hydr**OXY**zine / hydr**ALA**ZINE) · *"Is this your medicine?"* · Yes / Not this one |
| **LASA choice** | Two cards side by side (stacked at large text) with the differing letters highlighted · pick one or "Neither" |
| **Result** | Full-screen card: large status icon + word · one-sentence instruction · *"From your discharge papers:"* quote · Read aloud · Add to my questions · Scan next. Stop / Duplicate also get the checkbox *"I've set this bottle aside"* (logged; shown to the caregiver). Optional tip *"Write STOP on the cap"*, pending clinical-team approval |
| **My meds** | "4 of 6 bottles checked" · rows with status chip + "Scanned ✓" / "Not scanned yet" · details: plain-language directions, schedule, what changed |
| **Questions** | "Added for you" badge on auto items · big "Add a question" with mic (speech-to-text) · "Share with my doctor" → PDF preview |
| **Care team** | Invite by code + share sheet · list with role + Remove · alert settings in plain words |
| **Settings** | Text size, language, read-aloud speed, theme (light / dark / high contrast), notifications, sign out |
| **Dashboard (web)** | NavigationRail · patient table sorted red-first, with count badges that include text · master-detail plan verify (source lines left, editable items right) · keyboard shortcuts J / K (next / prev) and V (verify) · density toggle · same severity tokens as mobile |

### A13.5 Feedback and states
- **Loading:** content-shaped skeletons after a 300 ms delay; scanning shows progress, never a bare spinner.
- **Errors:** plain cause + next step, never error codes ("No internet. Your plan still works on this phone.").
- **Haptics:** tick on capture/lock; success on Taken; heavy warning when a red result appears. Haptics stay on under reduced motion.
- **Sound:** off by default.
- **Screen readers:** scan results are announced via a `liveRegion`.
- **Lock-screen notifications:** no drug names by default ("Time for your evening medicines (2)"). A setting can show names.

### A13.6 Microcopy (EN; ES via ARB)
| Moment | Copy |
|---|---|
| Empty Today | "Let's set up your medicines. Scan your discharge papers to start." |
| Scan hint | "Hold the bottle in the box. Turn it slowly." |
| Low confidence | "We couldn't read this clearly. Try again, or type it in." |
| Taken | "Marked as taken." [Undo] |
| Missed | "You haven't marked your 8:00 AM medicines. Take them now, or skip?" |
| Offline | "You're offline. Everything still works on this phone." |
| Stop | "Don't take this. Your care team stopped it." |

### A13.7 UI acceptance (adds to A5)
- **Every screen:**
  - Works at 200% text with wrapping and no truncation.
  - VoiceOver / TalkBack labels on every control; authored traversal order.
  - Passes a grayscale + color-blindness check.
  - Honors bold text; reduced motion collapses animations (haptics stay).
- **Usability:** 5 adults 65+ complete *scan papers → scan 3 bottles → mark a dose* unaided.

---

# PART B — BUILD (execute in order)

## B-1. Agent setup: skills, MCP, rules
Run in a terminal at the empty repo root. Needs Dart ≥ 3.9 for `dart mcp-server`.
```bash
# 1. Official Dart & Flutter plugin (skills + Dart/Flutter MCP config)
claude plugin marketplace add flutter/agent-plugins
claude plugin install dart-flutter@dart-flutter

# 2. Dart/Flutter MCP server: analyzer, pub, tests, hot reload, widget tree, screenshots
#    (skip if `claude mcp list` already shows it via the plugin)
claude mcp add --transport stdio dart -- dart mcp-server

# 3. Verify
claude plugin marketplace list
claude mcp list
```
4. **House-rule skills (HUMAN, one time):** enable the **Flutter Skills** plugin from your claude.ai plugin catalog. Then confirm the agent can see `flutter-conventions-index`, `state-management-riverpod`, `persistence-drift` and `accessibility-as-code`. **If it can't, stop.** The build depends on these rules.
5. **Optional (HUMAN):** the **Design** plugin (UX copy, a11y audit, design critique) and **Mobile App Design (iOS)** plugin (onboarding / permission flows), both used in B12's design review.
6. **Rules file.** Claude Code plugins don't load project rules automatically, so the agent writes `CLAUDE.md` at the repo root:
```markdown
# MedBridge — agent rules
- Source of truth: implementation.md (Part A = spec, Part B = ordered build steps).
- Before each step, load the skills listed for it in "Skills to load per step".
- House rules: flutter-conventions-index. Precedence: implementation.md > house-rule skills > dart-flutter plugin skills.
- After each step: run its "Done when" checks + tool/check.sh. Never continue on red.
- Synthetic data only. Never commit secrets (config/passwords.yaml, .env, service-account JSON are git-ignored).
- HUMAN-only: creating accounts, API keys, signing certificates, store submissions, real-device camera tests, clinical sign-offs. Stop and ask.
- Medical safety: never compute doses; never weaken the A8.2 rule table or the A8.4 invariants to make a test pass.
- Use the Dart MCP server for analysis, tests, hot reload and screenshots instead of guessing.
```
- **Done when:**
  - `claude mcp list` shows `dart`.
  - The agent lists the house-rule skills plus the dart-flutter skills.
  - `CLAUDE.md` exists.
  - `.gitignore` covers `config/passwords.yaml`, `.env*`, `*service-account*.json`, `google-services.json` and `GoogleService-Info.plist`.

## B0. Prerequisites and accounts (HUMAN: the agent checks each item and pauses if one is missing; it never creates accounts or commits secrets)
- Flutter stable, Dart 3, Xcode + Android Studio, Docker, Serverpod CLI (`dart pub global activate serverpod_cli`).
- **Firebase project:**
  - Enable Phone + Google sign-in.
  - Add **fictional test phone numbers**.
  - Download the service-account key.
  - Enable FCM.
- Google OAuth client IDs (iOS, Android, web).
- An SMTP account for email OTP (any free-tier email API).
- Secrets go in `medbridge_server/config/passwords.yaml` (git-ignored). Keys:
  - `emailSecretHashPepper`
  - `googleClientSecret`
  - Firebase service account
  - SMTP creds
  - FCM service account
- **Done when:** `flutter doctor` is clean; `serverpod version` works; `docker ps` works.

## B1. Scaffold
```bash
serverpod create medbridge          # → medbridge_server, medbridge_client, medbridge_flutter
cd medbridge
flutter create --platforms=web medbridge_dashboard
dart create -t package packages/med_core
flutter create -t package packages/med_ui
mkdir -p tools/synth_avs tools/eval docs
```
- **Wiring:**
  - Use path dependencies between packages.
  - `medbridge_flutter` and `medbridge_dashboard` depend on `medbridge_client`, `med_core` and `med_ui`.
  - `medbridge_server` depends on `med_core`.
- **Every package gets:**
  - `analysis_options.yaml` with pinned `very_good_analysis`, `strict-casts`, `strict-raw-types`.
  - The CI gate script `tool/check.sh`: `build_runner build -d` → `dart format --set-exit-if-changed .` → `dart analyze --fatal-infos --fatal-warnings` → tests.
- **Done when:** `tool/check.sh` passes on the empty scaffold; `docker compose up -d` in `medbridge_server` starts Postgres + Redis.

## B2. `med_core`: domain, NDC, sig parser
Files:
```
packages/med_core/lib/src/
  domain/  plan.dart  plan_item.dart  parsed_sig.dart  scan.dart  recon.dart  enums.dart  rule_set.dart
  ndc/     ndc.dart            # ndc11Candidates(String raw) -> List<String>; fromUpcA(String) ; fromGs1(String)
  sig/     sig_parser.dart     # ParsedSig parseSig(String raw, SigRules r)
           sig_render.dart     # String renderSig(ParsedSig s, Lang l, Templates t)
  util/    result.dart  clock.dart
packages/med_core/rules/ (all files from A9.4)
packages/med_core/test/
  ndc_test.dart  sig_parser_test.dart  sig_render_test.dart
  fixtures/sigs.csv     # ≥300 rows: raw,expected_json
```
- **NDC:**
  - Hyphenated input → exactly one candidate.
  - 10 digits, no hyphens → three candidates.
  - UPC-A → strip the leading `3` and the check digit.
- **Sig parser:**
  - Lowercase, normalize punctuation, tokenize.
  - Apply A6.4 and detect A6.5 flags.
  - Never throws; returns `ParsedSig` with `flags` + `conf`.
- **Renderer:** A6.6 templates only.
- **Done when:**
  - All rows in `sigs.csv` pass.
  - The NDC tests cover every format and ambiguous case.
  - `QOD`, "weekly", "1/2" and "1-2" each produce the right flag.

## B3. `med_core`: AVS + label parsers
Files:
```
lib/src/parse/
  ocr_types.dart        # OcrLine{text, box, page}, OcrFrame{lines, t}
  lexicon.dart          # Lexicon.match(String q) -> List<(String rxcui, double score)>  (trigram + edit distance)
  avs_parser.dart       # PlanDraft parseAvs(List<OcrLine> ls, Lexicon lx, AvsRules r)
  label_parser.dart     # ScanDraft parseLabel(List<OcrFrame> fs, Lexicon lx, Plan? ctx, Config c)
  vote.dart             # token majority vote across frames
  confidence.dart       # A7.3
test/
  avs_parser_test.dart  label_parser_test.dart  vote_test.dart
  fixtures/avs/*.json   fixtures/labels/*.json   (generated in B9, hand-checked)
```
- **Lexicon source:** a names list (IN, BN, SCD/SBD strings) exported from RxNorm's prescribable subset at build time into `assets/lexicon.tsv`.
- **Done when:**
  - The AVS fixtures produce the expected `PlanDraft` (action, name, strength, sig, src).
  - Label fixtures with injected OCR noise still resolve in closed-set mode.
  - LASA pairs force `needsChoice=true`.

## B4. `med_core`: reconciler + safety
Files:
```
lib/src/recon/
  reconcile.dart        # ReconResult reconcile(Plan p, Scan s, RuleSet r)  — A8.2 rows in order
  safety.dart           # List<SafetyFlag> check(Plan p, Scan s, RuleSet r, Patient pt) — A8.3
  rules_loader.dart     # RuleSet loadRules(Map json)
test/
  reconcile_rows_test.dart     # one test per row 0–10 + COMBO_PARTIAL
  reconcile_props_test.dart    # A8.4 invariants with generated inputs
  safety_test.dart
  golden_scenario_test.dart    # B10 scenario at the core level
```
- **Done when:**
  - Every row and invariant test passes.
  - `ruleVersion` is stamped on every result.
  - `med_core` has zero Flutter or Serverpod imports.

## B5. Server (`medbridge_server`)
1. **Models:** add all A9.2 `*.spy.yaml` files → `serverpod generate` → `serverpod create-migration` → `dart bin/main.dart --apply-migrations`.
2. **Auth:** `pod.initializeAuthServices(...)` with:
   - JWT token manager
   - Email OTP IdP, with an email-sending callback via the `mailer` package + SMTP
   - Google IdP
   - Firebase IdP

   Extend each provider's base endpoint (`EmailOtpIdpBaseEndpoint`, etc.).
3. **Roles:** a `role` scope on users (`patient`, `caregiver`, `pharmacist`, `clinician`, `pcp`, `admin`) + an `admin` CLI script to create clinician accounts.
4. **Endpoints:** everything in A10.
   - Shared guard `requireLink(session, patientId, roles)`.
   - Shared `audit(session, action, entity, id)`.
5. **RxNav proxy (`rx`):** `byNdc` → `/rxcui.json?idtype=NDC&id=`; `approximate` → `/approximateTerm.json`; `classesFor` → RxClass ATC.
   - Cache in `RxCache` for 30 days.
   - Token-bucket limiter at 20 req/s.
6. **Scan submit:** load the plan, prefetch classes/groups, run `med_core.reconcile` + `safety.check`, persist `ReconRow`. Then auto-create a `Question` and `Alert` per A8.4 #4.
7. **Alerts:** a future call every 15 min marks missed doses and evaluates the A5/F7 triggers. Send via the FCM HTTP v1 API (service account), with no PHI in the payload.
8. **Seed script** `bin/seed.dart`: synthetic users for every role + the B10 patient.
- **Done when:**
  - Endpoint tests pass, including authz: a caregiver can't edit a plan; an unlinked clinician gets 403.
  - The seed runs.
  - Submitting a fixture scan returns the expected status.

## B6. `med_ui`: design system + l10n
```
lib/src/tokens/   brand (navy, teal), severity palette (ok/info/amber/red + icon + label, separate from brand),
                  type scale (Atkinson Hyperlegible, body 18 sp, tabular figures), spacing, motion (reduced-motion aware)
lib/src/theme/    light (default), dark, high-contrast
lib/src/widgets/  AppTabScaffold (Today · Scan · My meds · Questions), AttentionBanner, NextDoseCard, SlotSection, PillRow,
                  StatusCard, SeverityBadge, PlanChip, SourceQuote, BigButton (56 dp), ConfirmField, TallManText,
                  ChoiceCompare (LASA), ScanGuideOverlay, ProgressRingLabeled, EmptyState, OfflineNote, CaregiverBanner
lib/src/text/     tall_man.dart (capitalizes differing letters from lasa_pairs.json)
assets/fonts/     AtkinsonHyperlegible-{Regular,Bold}.ttf
lib/l10n/         app_en.arb  app_es.arb  sig_templates_en.arb  sig_templates_es.arb  (A13.6 microcopy)
```
- **Rules:**
  - Severity is always icon + text + color.
  - Minimum 48 dp targets.
  - Never clamp the text scaler; directional geometry only.
- **Done when:**
  - Golden tests pass for every widget above (light/dark × EN/ES × 1.0/2.0 text scale), with `StatusCard` covering all 7 statuses.
  - Semantics tests pass.
  - `TallManText` renders the A13.4 hydroxyzine/hydralazine example correctly.

## B7. Mobile app (`medbridge_flutter`)
Structure (feature-first; Riverpod 3 `Notifier`s; repositories as the single write path; `Result<T, Failure>`):
```
lib/
  main.dart  bootstrap.dart  router.dart        # go_router with auth + onboarding guards, deep link /invite/:code
  core/  db/ (drift tables A9.3, SQLCipher)  sync/ (outbox → client endpoints)  services/ (Clock, Ocr, Barcode, DocScan, Tts, Notifier, Push)
  features/
    auth/          sign_in_screen, otp_screen, auth_notifier
    onboarding/    lang, role, text-size, permissions, allergies
    plan_capture/  capture_screen → review_screen (A5/F2), plan_repository
    bottle_scan/   scan_screen (live camera, rotate prompt) → confirm_screen → choice_screen (LASA)
    results/       result_screen (StatusCard + TTS + add question), plan_checklist_screen
    today/         today_screen (slots, Taken/Skip), schedule_repository, reminder_service
    questions/     questions_screen, export_pdf
    care_team/     invite_screen, links_screen
    settings/      language, text size, speech rate, sign out
```
- **Service interfaces:**
  - `Ocr`: wraps `google_mlkit_text_recognition`.
  - `Barcode`: wraps `mobile_scanner`.
  - `DocScan`: native document scanner plugin.
  - `Tts`: wraps `flutter_tts`.
  - `Notifier`: wraps `flutter_local_notifications` + `timezone`.
  - `Push`: wraps `firebase_messaging`.

  Each interface is faked in tests.
- **Packages:**
  - State / routing: `flutter_riverpod`, `riverpod_generator`, `go_router`.
  - Models: `freezed`, `json_serializable`.
  - Storage: `drift`, `sqlcipher_flutter_libs`, `flutter_secure_storage`.
  - Device / scanning: `camera`, `mobile_scanner`, `google_mlkit_text_recognition`.
  - Notifications / TTS: `flutter_local_notifications`, `timezone`, `flutter_tts`, `firebase_messaging`.
  - PDF: `pdf`, `printing`.
  - Serverpod: `serverpod_flutter`, `serverpod_auth_idp_flutter`.
  - Pin all at the latest stable at build time.
- **Every screen** renders loading / empty / error / content states.
- **Every screen follows A13.** The shell is `AppTabScaffold`; the screens and their elements are listed in A13.4.
- **Done when:**
  - Each feature's widget tests pass with fake services.
  - On a real device: scan a printed fixture AVS → review → scan a fixture bottle → correct card → reminder fires → PDF exports.

## B8. Dashboard (`medbridge_dashboard`, Flutter web)
```
lib/features/
  auth/            email OTP + Google; cookie-based web auth; 15-min idle timeout
  patients/        list with red/amber counts, search
  plan_verify/     side-by-side source lines ↔ items; edit; Verify
  flags/           flagged scans (red first), resolve with note
  questions/       inbox, answer
  summary/         PCP read-only summary
```
- **Done when:** a pharmacist seed user can verify the B10 plan, see its 3 red flags and 4 auto questions, and answer a question that then shows up in the app; audit rows exist for each view.

## B9. Tools: synthetic data + eval
- **`tools/synth_avs`** (Dart CLI):
  - Renders AVS PDFs/PNGs from JSON plans (Epic-like section headers, varied fonts / noise).
  - Renders pharmacy-label PNGs from templates with RxNorm names + sigs, warped onto a cylinder with glare / blur.
  - Emits matching ground-truth JSON.
- **`tools/eval`** (Dart CLI):
  - Runs `med_core` parsers on the fixture OCR output (and later on real-photo OCR exports).
  - Prints the A12 technical metrics, including the **silent-wrong** count.
- **Done when:** `dart run tools/eval` prints all A12 technical metrics over the generated set; silent-wrong = 0.

## B10. End-to-end golden scenario + CI
**Synthetic patient "R. Doe, 78".**

AVS:
- **START** losartan 50 mg tab, 1 tab PO daily
- **STOP** lisinopril 10 mg tab
- **CHANGE** metoprolol succinate ER 25 mg, 1 tab PO daily (was 50 mg)
- **CONTINUE** atorvastatin 40 mg, 1 tab PO QHS
- **HOLD** metformin 500 mg, 1 tab PO BID, until follow-up
- **Allergies:** penicillin

Bottles scanned → expected results:

| Bottle | Expected status | Reason / sev |
|---|---|---|
| lisinopril 10 mg | stop | `PLAN_STOP` / red |
| losartan 50 mg | newMed | `NEW_MED` / info |
| metoprolol succinate ER **50 mg** | changed | `OLD_STRENGTH_BOTTLE` / red |
| atorvastatin 40 mg | keep | `MATCH` / ok |
| metformin 500 mg | hold | `PLAN_HOLD` / amber |
| benazepril 20 mg (not on AVS) | duplicate | `SAME_CLASS_AS:losartan` (raas) / red |
| omeprazole 20 mg (not on AVS) | unknown | `NOT_ON_PLAN` / amber |

**Also expected:**
- 4 auto Questions: stop, changed-red, duplicate, unknown.
- Caregiver alert(s) for the red results.
- Reminders for losartan, metoprolol, atorvastatin only.

**Tests:**
- `golden_scenario_test.dart` in `med_core`.
- A server integration test (seed → submit 7 scans → assert rows).
- An app `integration_test` driving fake OCR / barcode services with the fixtures.

**CI** (GitHub Actions):
- Runs `tool/check.sh` for every package.
- Runs the server tests against the docker Postgres.
- Runs `tools/eval` (fails if silent-wrong > 0).
- Builds web for the dashboard and Android debug for the app.

**Done when:** CI is green on main.

## B11. Run and deploy (free, synthetic only)
**Local:**
```bash
cd medbridge_server && docker compose up -d && dart bin/main.dart --apply-migrations && dart run bin/seed.dart
cd ../medbridge_flutter && flutter run
cd ../medbridge_dashboard && flutter run -d chrome
```
**Shared dev server (free):**
- **Primary:** Oracle Cloud Always Free ARM VM (2 OCPU / 12 GB). Run Docker Compose with Serverpod + Postgres + Redis + Caddy (auto HTTPS). It's always on, so the alert future calls keep running. If ARM capacity errors occur, retry in another availability domain.
- **Fallback:** Render free web service (Serverpod Docker image) + **Neon** free Postgres. Render's free Postgres expires after 30 days, and the free web service sleeps after 15 min idle (alerts pause while it sleeps).
- **Dashboard:** static `flutter build web` → Firebase Hosting / Cloudflare Pages / Vercel free tier.
- **Push:** FCM (free). **Phone OTP:** fictional test numbers only (real SMS requires Firebase Blaze).
- Keep all infra in `deploy/` (compose file, Caddyfile, `.env.example`) so it can move to BAA hosting unchanged.

**Done when:** a teammate on their own phone can sign in (email or Google), run the B10 scenario with the printed fixtures, and see results mirrored in the dashboard.

## B12. Project definition of done
- [ ] Every A5 acceptance criterion is met; all B-step checks pass; CI is green.
- [ ] A12 technical gates met on the eval set (silent-wrong = 0).
- [ ] Usability session with the med team + ≥5 adults 65+ on synthetic data; SUS ≥ 70.
- [ ] `docs/` contains: setup guide, rule-file guide for the pharmacist, privacy notes, the open-questions log.

**Pilot gate** (outside this build; all required before real patients):
- [ ] BAA hosting; BAA status of the auth providers
- [ ] Carle IRB / QI determination
- [ ] Licensing for ISMP / Beers / DDI data
- [ ] Pharmacist sign-off on A8.2 wording + `class_groups.json`
- [ ] Translator-reviewed ES templates

---

# PART C — RISKS, OPEN QUESTIONS, REFERENCES

## C1. Risks
| Risk | Mitigation |
|---|---|
| Scan maps a critical drug / dose wrong (deck) | Barcode-first; closed-set matching; confirm screen; LASA gate; `ZERO_RISK`; silent-wrong = 0 gate |
| Data privacy (deck) | Synthetic only; SQLCipher; no images; audit log; BAA before real data |
| Older / low-literacy users (deck) | Big type, one action per screen, TTS, caregiver mode, usability tests with 65+ |
| Solo dev, large scope | Safety-critical core (`med_core`) built and tested first; extras are separable modules |
| AVS format variance | Header lexicon in JSON; review screen; pharmacist verification |
| Unsupported sigs | Detect + route to "ask"; never guess |
| Duplicate-class false positives | Pharmacist-curated groups; "may do the same job" wording |
| Rule-list licensing | Placeholder `"test": true` rows; legal check before pilot |
| Regulatory framing | Display the plan, don't direct therapy; Carle compliance review |

## C2. Open questions
| # | Question | Owner |
|---|---|---|
| Q1 | ~20 de-identified Carle AVS printouts; are START / CHANGE / CONTINUE / STOP headers consistent? | Clinical team |
| Q2 | Pharmacist reviewer for plan verification + rule wording | Peter Kim |
| Q3 | Hosting with a BAA: AWS vs Carle-hosted vs other; who signs? | Team + Carle IT |
| Q4 | Pilot cohort: own phones (iOS / Android mix), unit, size | Clinical team |
| Q5 | Which classes count as duplicates (ACE-I + ARB yes; aspirin 81 mg + clopidogrel?) | Pharmacist |
| Q6 | Licensing for ISMP lists, Beers Criteria, DDI source | Business team |
| Q7 | Spanish medical translator for templates | Business team |
| Q8 | IRB vs QI determination timeline | Clinical team |
| Q9 | Phase 2 Epic: is the discharge `MedicationRequest` category populated at Carle? AVS as a FHIR document? | Epic team |
| Q10 | Naming: the deck's Impact slide says "DispoBuddy"; confirm "MedBridge" | Team |

## C3. References
- Harris E. Polypharmacy nearly doubled in 20 years among older adults. *JAMA*. 2024.
- Weir DL, et al. Failure to follow medication changes made at hospital discharge. *Am J Med*. 2019.
- Armor BL, Wight AJ, Carter SM. *J Pharm Pract*. 2016;29(2):132-137.
- Coleman EA, et al. Posthospital medication discrepancies. *Arch Intern Med*. 2005;165(16):1842-1847.
- RxNav APIs — https://lhncbc.nlm.nih.gov/RxNav/APIs/
- RxNav FAQ (DDI API discontinued 2 Jan 2024) — https://lhncbc.nlm.nih.gov/RxNav/information/FAQs.html
- Serverpod auth — https://docs.serverpod.dev/concepts/authentication/setup
- Serverpod Firebase IdP — https://docs.serverpod.dev/next/concepts/authentication/providers/firebase/setup
- Firebase Auth limits (SMS on Blaze only) — https://firebase.google.com/docs/auth/limits
- Neon free plan — https://neon.com/faqs/free-plan-limits-and-quotas
- Gromova & Elangovan, distorted pill-bottle label extraction — https://www.mdpi.com/2504-4990/4/4/43
