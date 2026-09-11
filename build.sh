#!/bin/sh
# The Artifact platform wraps a page in <!doctype html><html><head>...<body> at
# publish time, so the source file deliberately has no document skeleton.
# Vercel serves files raw, and without a doctype the browser drops into quirks
# mode: document.scrollingElement becomes <body>, which breaks scroll timelines
# and sticky. This wraps the source into a standards-mode page for deployment.
set -e
SRC="${1:-under-one-roof.html}"
OUT="${2:-index.html}"

{
  printf '<!doctype html>\n<html lang="en">\n<head>\n'
  printf '<meta charset="utf-8">\n'
  printf '<meta name="viewport" content="width=device-width,initial-scale=1">\n'
  printf '<meta name="description" content="Think Layer records real human work from the operator point of view and turns it into training data for physical AI.">\n'
  printf '</head>\n<body>\n'
  cat "$SRC"
  printf '\n</body>\n</html>\n'
} > "$OUT"

echo "built $OUT from $SRC ($(wc -c < "$OUT" | tr -d ' ') bytes)"
