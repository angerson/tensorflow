#!/bin/bash

set -euxo pipefail

if git diff --name-only @~..@ | grep -v tensorflow/tools/ci_build/buildkite/packer/linux-image; then
  echo ":cake: Packer not changed, no changes necessary"
  exit 0
fi

echo "+++ :packer: for :gcp:"
packer build tools/ci_build/buildkite/packer/linux-image.json
