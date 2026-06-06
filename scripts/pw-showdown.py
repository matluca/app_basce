#!/usr/bin/env python3

import argparse
import base64
import json
import sys
from pathlib import Path

VALID_COLLECTIONS = ("passwords", "tb-passwords")


def load_backup(backup_file: str) -> dict:
    path = Path('firebase-backup', backup_file)
    if not path.is_file():
        raise FileNotFoundError(f"Backup file not found: {backup_file}")
    with path.open("r", encoding="utf-8") as fh:
        return json.load(fh)


def extract_collection(data: dict, collection: str) -> list:
    docs = data.get("data", {}).get(collection)
    if docs is None:
        raise KeyError(f"Collection '{collection}' not found in backup")
    return docs


def build_pwd_map(docs: list) -> dict[str, str]:
    return {
        doc["data"]["name"]: base64.b32decode(doc["data"]["pwd"], casefold=True).decode("utf-8")
        for doc in docs
        if "name" in doc.get("data", {}) and "pwd" in doc.get("data", {})
        and doc["data"]["name"] != "Admin"
    }


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Password showdown script."
    )
    parser.add_argument(
        "-b", "--backup_file",
        required=True,
        type=str,
        help="Backup file path or name",
    )
    parser.add_argument(
        "-c", "--collection",
        required=True,
        type=str,
        choices=VALID_COLLECTIONS,
        help="Collection to use: passwords or tb-passwords",
    )
    parser.add_argument(
        "-v", "--verbose",
        action="store_true",
        help="Print the full name→password dictionary instead of just sorted passwords",
    )
    args = parser.parse_args()

    try:
        data = load_backup(args.backup_file)
    except FileNotFoundError as exc:
        print(str(exc), file=sys.stderr)
        return 1

    try:
        docs = extract_collection(data, args.collection)
    except KeyError as exc:
        print(str(exc), file=sys.stderr)
        return 1

    pwd_map = build_pwd_map(docs)

    if args.verbose:
        for name, pwd in sorted(pwd_map.items(), key=lambda item: item[1]):
            print(f"{pwd}: {name}")
    else:
        for pwd in sorted(pwd_map.values()):
            print(pwd)

    return 0


if __name__ == "__main__":
    raise SystemExit(main())
