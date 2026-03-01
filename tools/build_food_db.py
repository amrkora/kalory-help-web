#!/usr/bin/env python3
"""Convert assets/food_ar.json to a SQLite database (assets/food.db).

Usage:
    python3 tools/build_food_db.py

The script reads the JSON food database, creates a SQLite file with FTS5
full-text search and a category index, and writes it to assets/food.db.
"""

import json
import os
import sqlite3
import sys
import time

DB_VERSION = 2
SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
PROJECT_DIR = os.path.dirname(SCRIPT_DIR)
JSON_PATH = os.path.join(PROJECT_DIR, "assets", "food_ar.json")
DB_PATH = os.path.join(PROJECT_DIR, "assets", "food.db")


def main():
    if not os.path.exists(JSON_PATH):
        print(f"Error: {JSON_PATH} not found")
        sys.exit(1)

    print(f"Reading {JSON_PATH} ...")
    t0 = time.time()
    with open(JSON_PATH, "r", encoding="utf-8") as f:
        foods = json.load(f)
    print(f"  Loaded {len(foods):,} entries in {time.time() - t0:.1f}s")

    # Remove old DB if it exists
    if os.path.exists(DB_PATH):
        os.remove(DB_PATH)

    print(f"Creating {DB_PATH} ...")
    t0 = time.time()
    conn = sqlite3.connect(DB_PATH)
    cur = conn.cursor()

    # Use WAL mode during build for speed, then switch back for read-only use
    cur.execute("PRAGMA journal_mode=WAL")
    cur.execute("PRAGMA synchronous=OFF")

    # Meta table for version tracking
    cur.execute("""
        CREATE TABLE meta (
            key   TEXT PRIMARY KEY,
            value TEXT NOT NULL
        )
    """)
    cur.execute("INSERT INTO meta (key, value) VALUES ('version', ?)", (str(DB_VERSION),))

    # Foods table (no n_lower — FTS5 handles search)
    cur.execute("""
        CREATE TABLE foods (
            id      INTEGER PRIMARY KEY,
            n       TEXT NOT NULL,
            c       TEXT NOT NULL,
            k       REAL NOT NULL,
            p       REAL NOT NULL,
            n_ar    TEXT NOT NULL DEFAULT '',
            c_ar    TEXT NOT NULL DEFAULT ''
        )
    """)

    # Batch insert
    rows = []
    for i, food in enumerate(foods):
        rows.append((
            i,
            food.get("n", ""),
            food.get("c", ""),
            food.get("k", 0),
            food.get("p", 0),
            food.get("n_ar", ""),
            food.get("c_ar", ""),
        ))

    cur.executemany(
        "INSERT INTO foods (id, n, c, k, p, n_ar, c_ar) VALUES (?, ?, ?, ?, ?, ?, ?)",
        rows,
    )

    print(f"  Inserted {len(rows):,} rows in {time.time() - t0:.1f}s")

    # Category index (used for NOT IN filtering)
    print("Creating category index ...")
    t0 = time.time()
    cur.execute("CREATE INDEX idx_foods_c ON foods (c)")
    print(f"  Index created in {time.time() - t0:.1f}s")

    # FTS5 full-text search table
    print("Creating FTS5 index ...")
    t0 = time.time()
    cur.execute("""
        CREATE VIRTUAL TABLE foods_fts USING fts5(
            n, n_ar,
            content='foods',
            content_rowid='id',
            tokenize='unicode61'
        )
    """)

    # Populate FTS5 index from main table
    cur.execute("INSERT INTO foods_fts(foods_fts) VALUES('rebuild')")
    print(f"  FTS5 index built in {time.time() - t0:.1f}s")

    conn.commit()
    cur.close()

    # Switch to DELETE journal mode for read-only asset use
    conn.execute("PRAGMA journal_mode=DELETE")
    conn.execute("VACUUM")
    conn.close()

    size_mb = os.path.getsize(DB_PATH) / (1024 * 1024)
    print(f"Done! {DB_PATH} ({size_mb:.1f} MB)")


if __name__ == "__main__":
    main()
