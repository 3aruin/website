#!/usr/bin/env bash
# Working File · build command for Cloudflare Workers Builds
#
# Hugo is preinstalled in the Workers Builds image, so this script doesn't
# install anything — it just builds. Pin the exact version with a build
# variable rather than in this file:
#   Settings > Build > Build Variables and Secrets
#   HUGO_VERSION = extended_0.163.0
# Cloudflare's own default (extended_0.147.7, as of this writing) is several
# minor versions behind current — pin it so the build doesn't silently drift
# as Cloudflare updates the image.
#
# Deploy is a separate step — Workers Builds runs its own "Deploy command"
# (defaults to npx wrangler deploy, reading the Wrangler version from
# package.json) after this script exits 0.
#
# Dashboard build command: bash build.sh

set -euo pipefail

echo "==> $(hugo version)"
hugo --gc --minify --cleanDestinationDir

if [[ ! -f public/index.html ]]; then
  echo "✘ public/index.html wasn't created — check the Hugo output above for errors" >&2
  exit 1
fi
