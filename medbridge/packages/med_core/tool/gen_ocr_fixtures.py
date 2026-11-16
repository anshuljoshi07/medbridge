"""Generates synthetic OCR fixtures for the B3 parser tests (seeded, repeatable).

    python3 tool/gen_ocr_fixtures.py

Writes test/fixtures/avs/*.json and test/fixtures/labels/*.json. Synthetic data
only: patient "R. Doe, 78" from B10. Noise model mimics ML Kit confusions on
curved, glary labels: l/1/I, O/0, S/5, B/8, rn/m, dropped characters.
"""
import json
import os
import random

ROOT = os.path.join(os.path.dirname(__file__), "..", "test", "fixtures")
CONFUSE = {"l": "1", "1": "l", "I": "l", "O": "0", "0": "O", "S": "5", "B": "8", "o": "0", "i": "l"}


def noisy(text, rnd, p):
    out, i = [], 0
    while i < len(text):
        ch = text[i]
        r = rnd.random()
        if text[i:i + 2] == "rn" and r < p:
            out.append("m"); i += 2; continue
        if r < p and ch in CONFUSE:
            out.append(CONFUSE[ch])
        elif r < p / 3 and ch.isalpha():
            pass  # dropped character
        else:
            out.append(ch)
        i += 1
    return "".join(out)


AVS_RDOE = [
    "Carle Foundation Hospital - After Visit Summary",
    "Patient: R. Doe   Age: 78",
    "Allergies: Penicillin",
    "START taking these medications",
    "losartan 50 mg tablet",
    "Take 1 tab PO daily",
    "Commonly known as: Cozaar",
    "CHANGE how you take these medications",
    "metoprolol succinate ER 25 mg tablet",
    "Take 1 tab PO daily",
    "CONTINUE taking these medications",
    "atorvastatin 40 mg tablet",
    "Take 1 tab PO QHS",
    "HOLD these medications",
    "metformin 500 mg tablet",
    "Take 1 tab PO BID",
    "until follow-up",
    "STOP taking these medications",
    "lisinopril 10 mg tablet",
    "Follow-up appointments",
    "See Dr. Smith in 1 week",
]
AVS_RDOE_EXPECTED = {
    "items": [
        {"action": "start", "ing": "losartan", "strength": "50 mg", "sig": "Take 1 tab PO daily"},
        {"action": "change", "ing": "metoprolol", "strength": "25 mg", "sig": "Take 1 tab PO daily"},
        {"action": "keep", "ing": "atorvastatin", "strength": "40 mg", "sig": "Take 1 tab PO QHS"},
        {"action": "hold", "ing": "metformin", "strength": "500 mg", "sig": "Take 1 tab PO BID"},
        {"action": "stop", "ing": "lisinopril", "strength": "10 mg", "sig": ""},
    ],
    "allergies": ["penicillin", "penicillins"],
    "unrecognized": 0,
}

AVS_MESSY = [
    "ALLERGIES: none known",
    "• START TAKING:",
    "1. losartan 50 mg tab, take 1 tab by mouth once daily",
    "CONTINUE TAKING:",
    "2. atorvastatin 40 mg tab",
    "take 1 tab PO at bedtime",
    "3. prednisone 10 mg tab",
    "Take 4 tabs daily x 3 days then 2 tabs daily",
    "Ask your nurse about this one ???",
    "STOP TAKING:",
    "4. lisinopril 10 mg tab",
]
AVS_MESSY_EXPECTED = {
    "items": [
        {"action": "start", "ing": "losartan", "strength": "50 mg", "sig": "take 1 tab by mouth once daily"},
        {"action": "keep", "ing": "atorvastatin", "strength": "40 mg", "sig": "take 1 tab PO at bedtime"},
        {"action": "keep", "ing": "prednisone", "strength": "10 mg", "sig": "Take 4 tabs daily x 3 days then 2 tabs daily", "flags": ["TAPER"]},
        {"action": "stop", "ing": "lisinopril", "strength": "10 mg", "sig": ""},
    ],
    "allergies": [],
    "unrecognized": 1,
}


def label(drug_line, sig, rx="RX 4471209", extra=None):
    lines = ["CARLE PHARMACY  217-555-0100", rx, drug_line.upper(), sig.upper(),
             "QTY: 30   REFILLS: 2", "FILLED: 11/01/2026", "DR. A. SMITH"]
    return lines + (extra or [])


LABELS = {
    "lisinopril_10": (label("lisinopril 10 mg tablet", "Take 1 tablet by mouth daily"),
                      {"ing": "lisinopril", "strength": "10 mg", "needsChoice": False}),
    "losartan_50": (label("losartan potassium 50 mg tab", "Take 1 tablet by mouth daily"),
                    {"ing": "losartan", "strength": "50 mg", "needsChoice": False}),
    "metoprolol_er_50": (label("metoprolol succ ER 50 mg tab", "Take 1 tablet by mouth daily"),
                         {"ing": "metoprolol", "strength": "50 mg", "release": "extended", "needsChoice": False}),
    "atorvastatin_40": (label("atorvastatin 40 mg tablet", "Take 1 tablet by mouth at bedtime"),
                        {"ing": "atorvastatin", "strength": "40 mg", "needsChoice": False}),
    "metformin_500": (label("metformin HCl 500 mg tablet", "Take 1 tablet by mouth twice daily"),
                      {"ing": "metformin", "strength": "500 mg", "needsChoice": True}),
    "benazepril_20": (label("benazepril 20 mg tablet", "Take 1 tablet by mouth daily"),
                      {"ing": "benazepril", "strength": "20 mg", "needsChoice": False}),
    "omeprazole_20": (label("omeprazole DR 20 mg capsule", "Take 1 capsule by mouth daily before breakfast"),
                      {"ing": "omeprazole", "strength": "20 mg", "needsChoice": False}),
    "hydroxyzine_25": (label("hydroxyzine HCl 25 mg tablet", "Take 1 tablet by mouth three times daily"),
                       {"ing": "hydroxyzine", "strength": "25 mg", "needsChoice": True}),
}


def frames_for(lines, rnd, n=6, p=0.05):
    """Rotation: each frame shows ~75% of lines; every line in >= 4 frames."""
    seen = {i: 0 for i in range(len(lines))}
    frames = []
    for f in range(n):
        vis = [i for i in range(len(lines)) if rnd.random() < 0.75 or seen[i] < 4 - (n - f - 1)]
        for i in vis:
            seen[i] += 1
        frames.append([noisy(lines[i], rnd, p) for i in vis])
    return frames


def write(path, obj):
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "w") as fh:
        json.dump(obj, fh, indent=1, ensure_ascii=False)
        fh.write("\n")


def main():
    rnd = random.Random(20261116)
    write(os.path.join(ROOT, "avs", "rdoe_clean.json"), {"lines": AVS_RDOE, "expected": AVS_RDOE_EXPECTED})
    write(os.path.join(ROOT, "avs", "rdoe_noisy.json"),
          {"lines": [noisy(l, rnd, 0.02) for l in AVS_RDOE], "expected": AVS_RDOE_EXPECTED})
    write(os.path.join(ROOT, "avs", "messy.json"), {"lines": AVS_MESSY, "expected": AVS_MESSY_EXPECTED})
    for name, (lines, expected) in LABELS.items():
        write(os.path.join(ROOT, "labels", f"{name}.json"),
              {"frames": frames_for(lines, rnd), "expected": expected, "context": "rdoe"})
        write(os.path.join(ROOT, "labels", f"{name}_single.json"),
              {"frames": [lines], "expected": expected, "context": "rdoe"})
    print("fixtures written")


if __name__ == "__main__":
    main()
