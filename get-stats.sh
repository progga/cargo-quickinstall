#!/bin/bash
set -euo pipefail

curl \
  --user-agent "cargo-quickinstall build pipeline (alsuren@gmail.com)" \
  --silent \
  --show-error \
  -XGET \
  "https://warehouse-clerk-tmp.vercel.app/api/stats" | (
  # Slight hack: if TARGET_ARCH is specified then just print crate names one per line.
  # Otherwise print all counts as json.
  if [[ "${TARGET_ARCH:-}" != "" ]]; then
    jq -r 'keys | .[]' |
      (grep -F "${TARGET_ARCH:-}" || true) |
      sed 's:/.*::'
  else
    jq '.'
  fi
)
