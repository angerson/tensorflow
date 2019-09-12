#!/bin/bash

set -euxo pipefail

if git diff --name-only @~..@ | grep tensorflow/tools/ci_build/buildkite/packer/linux-image; then
  echo "+++ :packer: for :docker:"
  packer build tools/ci_build/buildkite/packer/linux-image.json
else
  echo "Image config not changed, no updates necessary"
fi
