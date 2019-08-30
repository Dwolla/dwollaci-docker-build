#!/bin/sh
set -eu

DOCKERFILE=${1}
shift

BUILD_ID_FILE=$(mktemp)

docker build \
  --file "${DOCKERFILE}" \
  --iidfile "${BUILD_ID_FILE}" \
  .

BUILD_ID=$(cut -d : -f 2 "${BUILD_ID_FILE}")
for arg; do
  docker tag "${BUILD_ID}" "${arg}"
  if [ -x "/root/.docker/config.json" ]; then
    docker push "${arg}"
  fi
done
