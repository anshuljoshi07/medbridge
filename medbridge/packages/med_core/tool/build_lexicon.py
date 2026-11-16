"""Builds assets/lexicon.tsv from RxNorm's prescribable subset (B3).

Columns: rxcui, tty, name, ingredients (|-separated), atc4 classes (|-separated)

- IN / MIN / BN names come from RxNav Prescribe `allconcepts`.
- BN -> IN mapping and IN -> ATC level-4 classes come from RxNav / RxClass.
- Throttled to stay under NLM's 20 requests/second limit.

Usage (from packages/med_core):  python3 tool/build_lexicon.py
Takes ~10 minutes. Re-run when RxNorm updates; commit the TSV.
"""
import concurrent.futures as cf
import json
import os
import threading
import time
import urllib.request

BASE = "https://rxnav.nlm.nih.gov/REST"
OUT = os.path.join(os.path.dirname(__file__), "..", "assets", "lexicon.tsv")
RATE = 15  # requests per second, below the 20/s limit

_lock = threading.Lock()
_next = [0.0]


def get(path):
    with _lock:
        wait = _next[0] - time.monotonic()
        if wait > 0:
            time.sleep(wait)
        _next[0] = max(_next[0], time.monotonic()) + 1.0 / RATE
    for attempt in range(4):
        try:
            req = urllib.request.Request(BASE + path, headers={"User-Agent": "medbridge-lexicon-builder"})
            with urllib.request.urlopen(req, timeout=30) as r:
                return json.load(r)
        except Exception:  # noqa: BLE001 - retry transient network errors
            time.sleep(2 ** attempt)
    return {}


def concepts(tty):
    d = get(f"/Prescribe/allconcepts.json?tty={tty}")
    return d.get("minConceptGroup", {}).get("minConcept", [])


def bn_ingredients(rxcui):
    d = get(f"/rxcui/{rxcui}/related.json?tty=IN")
    out = []
    for g in d.get("relatedGroup", {}).get("conceptGroup", []) or []:
        for c in g.get("conceptProperties", []) or []:
            out.append(c["name"].lower())
    return sorted(set(out))


def atc4(rxcui):
    d = get(f"/rxclass/class/byRxcui.json?rxcui={rxcui}&relaSource=ATC")
    out = set()
    for info in d.get("rxclassDrugInfoList", {}).get("rxclassDrugInfo", []) or []:
        cid = info.get("rxclassMinConceptItem", {}).get("classId", "")
        if len(cid) == 5:
            out.add(cid)
    return sorted(out)


def main():
    ins = concepts("IN")
    mins = concepts("MIN")
    bns = concepts("BN")
    print(f"IN={len(ins)} MIN={len(mins)} BN={len(bns)}")
    with cf.ThreadPoolExecutor(max_workers=8) as pool:
        in_atc = dict(zip([c["rxcui"] for c in ins], pool.map(atc4, [c["rxcui"] for c in ins])))
        print("ATC done")
        bn_ings = dict(zip([c["rxcui"] for c in bns], pool.map(bn_ingredients, [c["rxcui"] for c in bns])))
        print("BN done")
    atc_by_name = {c["name"].lower(): in_atc.get(c["rxcui"], []) for c in ins}

    def classes(ings):
        return sorted({a for i in ings for a in atc_by_name.get(i, [])})

    rows = []
    for c in ins:
        n = c["name"].lower()
        rows.append((c["rxcui"], "IN", n, [n], in_atc.get(c["rxcui"], [])))
    for c in mins:
        ings = sorted(p.strip().lower() for p in c["name"].split(" / "))
        rows.append((c["rxcui"], "MIN", c["name"].lower(), ings, classes(ings)))
    for c in bns:
        ings = bn_ings.get(c["rxcui"], [])
        if ings:
            rows.append((c["rxcui"], "BN", c["name"].lower(), ings, classes(ings)))
    os.makedirs(os.path.dirname(OUT), exist_ok=True)
    with open(OUT, "w") as fh:
        fh.write("# rxcui\ttty\tname\tingredients\tatc4  (RxNorm prescribable subset via RxNav)\n")
        for rxcui, tty, name, ings, atc in sorted(rows, key=lambda r: (r[2], r[1])):
            fh.write(f"{rxcui}\t{tty}\t{name}\t{'|'.join(ings)}\t{'|'.join(atc)}\n")
    print(f"wrote {len(rows)} rows to {OUT}")


if __name__ == "__main__":
    main()
