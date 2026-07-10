"""Remove Cursor co-author lines from git commit messages."""
import sys

data = sys.stdin.read()
lines = [line for line in data.splitlines(True) if "Co-authored-by: Cursor" not in line]
sys.stdout.write("".join(lines))
