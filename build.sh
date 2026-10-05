#!/usr/bin/env bash
# Build tvhead_arm64_lite.tar (docker-archive, linux/arm64) for RouterOS /container.
# Run from the repository root of vuducdong/tvheadend (with this package copied in).
# Needs Docker with buildx; on a non-arm64 host QEMU/binfmt is required:
#   docker run --privileged --rm tonistiigi/binfmt --install arm64
set -euo pipefail
OUT="${1:-tvhead_arm64_lite.tar}"
TAG="${TAG:-tvheadend-iptv-lite:latest}"
docker buildx build --platform linux/arm64 -f Containerfile.iptv-lite \
    --output "type=docker,dest=${OUT}" -t "${TAG}" .
sha256sum "${OUT}" | tee "${OUT}.sha256"
ls -l "${OUT}"
