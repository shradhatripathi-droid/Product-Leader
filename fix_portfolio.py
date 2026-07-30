#!/usr/bin/env python3
"""Fix 0x9d encoding corruption in Product-Leader portfolio files."""

from __future__ import annotations

import re
from pathlib import Path

ROOT = Path(__file__).resolve().parent
BAD = "\x9d"
MID = "\u00b7"
EM = "\u2014"
EN = "\u2013"
TIMES = "\u00d7"
ARR = "\u2192"
HARR = "\u2194"

FILES = [
    ROOT / "index.html",
    ROOT / "README.md",
]


def fix_text(text: str) -> str:
    text = text.replace("20 ? 1.9M", f"20 {ARR} 1.9M")
    text = text.replace("Bloomberg ? Traders", f"Bloomberg {HARR} Traders")
    text = text.replace(f'data-suffix="{BAD}"', f'data-suffix="{TIMES}"')
    text = text.replace(f"91{BAD}", f"91{TIMES}")
    text = text.replace(f"3{BAD}", f"3{TIMES}")
    text = text.replace(f"$8{BAD}10M", f"$8{EN}10M")

    text = re.sub(r"(\d{4}) ?" + re.escape(BAD) + r" ?Present", rf"\1 {EN} Present", text)
    text = re.sub(r"(\d{4}) ?" + re.escape(BAD) + r" ?(\d{4})", rf"\1 {EN} \2", text)

    em_dash_patterns = [
        r"(<title>Shradha Tripathi) " + re.escape(BAD) + r" (Product Management Leader)",
        r"(Product Management Leader) " + re.escape(BAD) + r" (Fintech)",
        r"(Staff PM) " + re.escape(BAD) + r" (Technical)",
        r"(Sr\. Technical PM) " + re.escape(BAD) + r" (Alexa)",
        r"(Built for GitHub) " + re.escape(BAD) + r" (Product Management Leader Portfolio)",
    ]
    for pattern in em_dash_patterns:
        text = re.sub(pattern, rf"\1 {EM} \2", text)

    text = text.replace(BAD, MID)
    return text


def main() -> None:
    for path in FILES:
        if not path.exists():
            continue
        original = path.read_text(encoding="latin-1")
        fixed = fix_text(original)
        path.write_text(fixed, encoding="utf-8")
        print(f"Fixed {path.name}: remaining bad bytes={fixed.count(BAD)}")


if __name__ == "__main__":
    main()
