#!/usr/bin/env bash
#
# Deployment helper for DriftDetect.
# Builds the container image and optionally pushes it to the configured registry.
set -euo pipefail

SERVICE="driftdetect"
REGISTRY="${REGISTRY:-ghcr.io/devnilethegreat}"
TAG="${TAG:-latest}"
IMAGE="${REGISTRY}/${SERVICE}:${TAG}"

log() { printf '[%s] %s\n' "$(date -u +%H:%M:%S)" "$*"; }

build() {
  log "Building image ${IMAGE}"
  docker build -t "${IMAGE}" .
}

push() {
  log "Pushing ${IMAGE}"
  docker push "${IMAGE}"
}

main() {
  build
  if [[ "${PUSH:-false}" == "true" ]]; then
    push
  fi
  log "Deployment routine for DriftDetect complete."
}

main "$@"