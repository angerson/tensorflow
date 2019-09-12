#!/bin/bash

set -euxo pipefail

if git diff --name-only @~..@ | grep -v tensorflow/tools/ci_build/buildkite/packer/linux-container; then
  echo ":cake: Packer not changed, no changes necessary"
  exit 0
fi

echo "+++ :packer: for :docker:"
packer build tools/ci_build/buildkite/packer/linux-container.json
