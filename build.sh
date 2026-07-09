#!/usr/bin/env bash
# Working File · build script for Cloudflare Workers
#
# Builds the Hugo site into ./public and deploys it with Wrangler. Pins a
# specific Hugo version so the build is reproducible in CI rather than
# depending on whatever happens to be preinstalled on the runner.
#
# Requires for the deploy step: Node.js (for `npx wrangler`), plus either
#   - `wrangler login` run once interactively (local use), or
#   - CLOUDFLARE_API_TOKEN, and CLOUDFLARE_ACCOUNT_ID if the token can see
#     more than one account, set as environment variables (CI use).
#
# If this script is set as the "Build command" in Cloudflare's own
# git-connected Workers Builds, drop the final `npx wrangler deploy` line —
# Workers Builds deploys automatically once the build command exits 0.

set -euo pipefail

HUGO_VERSION="0.163.0"

version_matches() {
  "$1" version 2>/dev/null | grep -q "v${HUGO_VERSION}"
}

# ─── 1. Resolve a Hugo binary ───────────────────────────────────────────────
# Reuse an already-installed Hugo if it's the pinned version (covers local
# dev on macOS/Windows/Linux). Otherwise download the pinned Linux binary
# into a project-local .bin/ — no sudo, no PATH changes, safe in any CI
# container. Standard (non-extended) edition: this site has no Sass/PostCSS
# pipeline (B-031), so extended buys nothing here.
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

# ─── 2. Build ────────────────────────────────────────────────────────────────
echo "==> Building site"
"$HUGO_BIN" --gc --minify --cleanDestinationDir

# ─── 3. Deploy ───────────────────────────────────────────────────────────────
echo "==> Deploying to Cloudflare Workers"
npx wrangler deploy
