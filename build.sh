#!/usr/bin/env bash
# Working File · build command for Cloudflare Workers Builds
#
# Builds the Hugo site into ./public. That's all this script does now —
# deploy is a separate step. Workers Builds runs its own "Deploy command"
# (Settings > Build in the Cloudflare dashboard) after this exits 0; it
# defaults to `npx wrangler deploy` and reads the Wrangler version from
# package.json, so no change is needed there. Cloudflare also handles auth
# for that step automatically (an account-scoped API token, generated when
# Workers Builds was first connected) — nothing to configure here for that
# either.
#
# Pins a specific Hugo version so the build is reproducible in CI rather
# than depending on whatever happens to be preinstalled on the runner.
#
# Dashboard build command: bash build.sh

set -euo pipefail

HUGO_VERSION="0.163.0"

version_matches() {
  "$1" version 2>/dev/null | grep -q "v${HUGO_VERSION}"
}

# ─── Resolve a Hugo binary ──────────────────────────────────────────────────
# Reuse an already-installed Hugo if it's the pinned version (covers local
# dev on macOS/Windows/Linux). Otherwise download the pinned Linux binary
# into a project-local .bin/ — no sudo, no PATH changes, safe inside the
# Workers Builds container or any other Linux CI. Standard (non-extended)
# edition: this site has no Sass/PostCSS pipeline (B-031), so extended buys
# nothing here.
if command -v hugo >/dev/null 2>&1 && version_matches hugo; then
  HUGO_BIN="hugo"
else
  BIN_DIR="$(pwd)/.bin"
  HUGO_BIN="${BIN_DIR}/hugo"
  mkdir -p "$BIN_DIR"
  if [[ ! -x "$HUGO_BIN" ]] || ! version_matches "$HUGO_BIN"; then
    echo "==> Installing Hugo v${HUGO_VERSION} (linux-amd64)"
    ARCHIVE="hugo_${HUGO_VERSION}_linux-amd64.tar.gz"
    curl -fsSL "https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${ARCHIVE}" -o /tmp/hugo.tar.gz
    tar -xzf /tmp/hugo.tar.gz -C "$BIN_DIR" hugo
    chmod +x "$HUGO_BIN"
    rm -f /tmp/hugo.tar.gz
  fi
fi

echo "==> $("$HUGO_BIN" version)"

# ─── Build ───────────────────────────────────────────────────────────────────
echo "==> Building site"
"$HUGO_BIN" --gc --minify --cleanDestinationDir
