"""Generates test/fixtures/sigs.csv: raw sig text -> expected ParsedSig fields.

Ground truth is built from independently specified components (A6.4 table),
not from the parser. Re-run after changing the component lists:
    python3 tool/gen_sigs.py
"""
import csv, itertools, json, os

qtys = [("1", 1), ("2", 2), ("one", 1), ("two", 2)]
units = [("tab", "tablet"), ("tablet", "tablet"), ("cap", "capsule"), ("capsules", "capsule")]
routes = [("PO", "oral"), ("by mouth", "oral"), ("", None)]
M, N, A, E, B = "morning", "noon", "afternoon", "evening", "bedtime"
freqs = [
    ("daily", dict(perDay=1, slots=[M])),
    ("QD", dict(perDay=1, slots=[M])),
    ("once daily", dict(perDay=1, slots=[M])),
    ("BID", dict(perDay=2, slots=[M, E])),
    ("twice daily", dict(perDay=2, slots=[M, E])),
    ("TID", dict(perDay=3, slots=[M, N, E])),
    ("QID", dict(perDay=4, slots=[M, N, E, B])),
    ("3 times a day", dict(perDay=3, slots=[M, N, E])),
    ("QHS", dict(perDay=1, slots=[B])),
    ("at bedtime", dict(perDay=1, slots=[B])),
    ("QAM", dict(perDay=1, slots=[M])),
    ("QPM", dict(perDay=1, slots=[E])),
    ("q12h", dict(everyH=12, slots=[M, E])),
    ("q8h", dict(everyH=8, slots=[M, A, B])),
    ("every 6 hours", dict(everyH=6, slots=[M, N, E, B])),
    ("q6h PRN", dict(everyH=6, slots=[], prn=True)),
    ("q6h PRN max 4/day", dict(everyH=6, slots=[], prn=True, prnMax=4)),
    ("as needed", dict(slots=[], prn=True)),
]
foods = [("", None), ("PC", "after"), ("with meals", "withFood")]

def expected(q, u, r, f, food):
    e = {"qty": q, "unit": u, "route": r, "perDay": None, "everyH": None,
         "slots": [], "prn": False, "prnMax": None, "food": food, "flags": []}
    e.update(f)
    return e

rows = []
for (qt, qv), (ut, uv), (rt, rv), (ft, fv), (fd, fdv) in itertools.product(qtys, units, routes, freqs, foods):
    # keep the set varied but bounded: rotate food/route choices
    if (len(rows) % 3) and fd:
        continue
    raw = " ".join(p for p in ["Take", qt, ut, rt, ft, fd] if p)
    rows.append((raw, expected(qv, uv, rv, ft and fv, fdv)))

# Other routes and units.
extra = [
    ("Inhale 2 puffs INH q4h PRN", dict(qty=2, unit="puff", route="inhalation", everyH=4, prn=True)),
    ("Instill 1 gtt OU BID", dict(qty=1, unit="drop", route="ophthalmic", perDay=2, slots=[M, E])),
    ("Instill 1 drop OD daily", dict(qty=1, unit="drop", route="ophthalmic", perDay=1, slots=[M])),
    ("Instill 2 gtts OS TID", dict(qty=2, unit="drop", route="ophthalmic", perDay=3, slots=[M, N, E])),
    ("Apply 1 patch TD daily", dict(qty=1, unit="patch", route="transdermal", perDay=1, slots=[M])),
    ("Place 1 tab SL PRN", dict(qty=1, unit="tablet", route="sublingual", prn=True)),
    ("Take 1 tab PO daily AC", dict(qty=1, unit="tablet", route="oral", perDay=1, slots=[M], food="before")),
    ("Take 1 tab PO BID x 10 days", dict(qty=1, unit="tablet", route="oral", perDay=2, slots=[M, E])),
]
for raw, f in extra:
    e = expected(f.pop("qty"), f.pop("unit"), f.pop("route"), {}, f.pop("food", None))
    e.update(f)
    rows.append((raw, e))

unsupported = [
    ("Take 2 tabs daily x 3 days then 1 tab daily", ["TAPER"]),
    ("Take 40 mg daily, decrease by 10 mg every week", ["TAPER", "NON_DAILY"]),
    ("Taper as directed", ["TAPER"]),
    ("Take 1 tab weekly", ["NON_DAILY"]),
    ("Take 1 tab once a week", ["NON_DAILY"]),
    ("Take 1 tab QOD", ["NON_DAILY"]),
    ("Take 1 tab every other day", ["NON_DAILY"]),
    ("Take 1 tab on Mondays", ["NON_DAILY"]),
    ("Take 6 tabs every Sunday", ["NON_DAILY"]),
    ("Inject per sliding scale", ["SLIDING_SCALE"]),
    ("Inject units based on blood sugar", ["SLIDING_SCALE"]),
    ("Take 1/2 tab PO daily", ["HALF_TAB"]),
    ("Take ½ tab daily", ["HALF_TAB"]),
    ("Take half a tablet daily", ["HALF_TAB"]),
    ("Take 5 mL PO BID", ["LIQUID_VOLUME"]),
    ("Take 1 tsp PO TID", ["LIQUID_VOLUME"]),
    ("Take 1-2 tabs PO q6h PRN", ["RANGE_DOSE"]),
    ("Take 1 to 2 tabs PO PRN", ["RANGE_DOSE"]),
    ("Take 2–3 caps daily", ["RANGE_DOSE"]),
    ("Take 1.0 tab PO daily", ["ZERO_RISK"]),
    ("Take .5 mg PO daily", ["ZERO_RISK"]),
]
rows_unsupported = [(raw, {"flags": flags}) for raw, flags in unsupported]

path = os.path.join(os.path.dirname(__file__), "..", "test", "fixtures", "sigs.csv")
with open(path, "w", newline="") as fh:
    w = csv.writer(fh)
    w.writerow(["raw", "expected_json"])
    for raw, e in rows + rows_unsupported:
        w.writerow([raw, json.dumps(e, separators=(",", ":"))])
print(len(rows) + len(rows_unsupported), "rows")
