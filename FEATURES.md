# MedBridge feature guide

What each part of MedBridge does today, how to try it, and what's still to come.
Test logins and invite codes are in the [README](README.md#test-logins). In development every account uses code `123456`.

✅ = working now · 🟡 = partly done · ⏳ = not built yet

---

## For patients

| Feature | Status | How to try it |
|---|---|---|
| **Sign in** with an email one-time code | ✅ | Any `@medbridge.test` email, code `123456` |
| Google sign-in, phone code | ⏳ | Needs Firebase / Google accounts |
| **Onboarding**: language → role → name and text-size preview → reminders explained → allergies | ✅ | First sign-in on a new browser |
| **Scan discharge papers** → review screen | 🟡 | Scan → Scan discharge papers → *Use the sample papers*. In the browser you type or paste text; the phone camera isn't built yet |
| Review: items grouped (New / Changed / Keep / Paused / Stopped), each with its **source line**, unclear items must be ticked, unreadable lines kept | ✅ | Same flow; tap **Looks right** to save |
| **Scan a bottle** → confirm → result | 🟡 | Scan → Scan bottle → pick a sample bottle, or type the label. No camera or barcode yet |
| **Look-alike names** (e.g. hydrOXYzine / hydrALAZINE): forced choice between the two | ✅ | Sample bottle *hydroxyzine* or *metformin* |
| **Result card**: status as icon + word + color, one-line instruction, quote from your papers | ✅ | After any bottle scan |
| **Read aloud** | ✅ | Result card → Read aloud |
| "I've set this bottle aside" required for Stop and Duplicate results | ✅ | Scan the *lisinopril* or *benazepril* sample |
| **Today**: needs-attention card, next dose, Morning / Noon / Evening / Bedtime, Taken / Skip with 5-second Undo, "3 of 5 taken" | ✅ | Today tab as R. Doe |
| Reminder notifications on the phone | ⏳ | Not on web; phone app needed |
| **My meds**: bottles checked, status per medicine, "Pick up from pharmacy" list | ✅ | My meds tab |
| **Questions**: auto-added ones ("Added for you"), add your own, answers from the care team | ✅ | Questions tab |
| **Share with my doctor**: one-page PDF | ✅ | Questions → Share with my doctor |
| **Care team**: invite by code, remove | ✅ | Group icon in the top bar |
| **Settings**: English / Español, light / dark / high-contrast theme, read-aloud speed, sign out | ✅ | Avatar in the top bar |
| Works offline: results are worked out on the device if the server is unreachable | 🟡 | Result screen shows "You're offline…"; the encrypted on-device database isn't built yet |

## For caregivers

| Feature | Status | How to try it |
|---|---|---|
| Join with an invite code | ✅ | New account → "I help someone" → code `CARE2345` or `RDCG2345` |
| View the patient's plan, results, schedule and questions (read-only), with the banner "Viewing {name}'s medicines" | ✅ | `caregiver@medbridge.test` |
| Switch between patients when linked to more than one | ✅ | Tap the banner |
| Add questions for the patient | ✅ | Questions tab |
| **Alerts** for red results, 2 missed doses in a row, or a missed high-risk medicine | 🟡 | Created and logged on the server (no medicine names in the text); push to the phone not wired up yet |

## For pharmacists, clinicians and doctors

| Feature | Status |
|---|---|
| Accounts created by an admin only (`dart run bin/admin.dart create-clinician EMAIL ROLE`) | ✅ |
| See only patients who invited you; every view is audit-logged | ✅ |
| Pharmacist verifies and edits plans; clinicians and doctors read and answer | ✅ (server API) |
| **Clinician web dashboard**: patient list (red first), plan verification, flagged scans, questions inbox, doctor summary | ⏳ Server side is ready; screens not built yet |

## Safety rules (the core)

All built and tested (1,470 automated tests):

- **Reconciliation rules**: Continue · Changed · Stop · New · Hold · Duplicate · Unknown, checked in a fixed order.
- **Duplicate detection** by drug class, so an old ACE inhibitor bottle next to a new ARB gets flagged (the deck's incident).
- **Strength and form checks**: old-strength bottle, ER vs immediate release, 1000 mcg = 1 mg (for comparison only).
- **Unsupported directions are never guessed**: tapers, weekly, sliding scale, half-tablets, liquid volumes and dose ranges become "Ask your pharmacist".
- **Error-prone notation** such as `1.0 mg` or `.5 mg` forces the patient to confirm.
- **Safety overlays**: allergies (including by class, e.g. penicillins), drug interactions, high-risk medicines, look-alike names. They can raise a warning, never lower one.
- **Never computes a dose.** The same rules run on the device and the server and stamp the same rule version.
- Drug names come from RxNorm (10,988 prescribable names). The rule lists are **placeholders marked `"test": true`** until they're licensed and a pharmacist signs off.

## Still to build

Clinician dashboard · phone app (camera, barcode, text recognition, reminders, encrypted storage) · push notifications · Google and phone sign-in · real email delivery · data and evaluation tools · CI and screenshot tests · hosted shared server. Full list in [`docs/progress.md`](docs/progress.md).
