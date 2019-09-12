#!/bin/bash

set -euxo pipefail

if git diff --name-only @~..@ | grep tensorflow/tools/ci_build/buildkite/packer/linux-container; then
  echo "+++ :packer: for :docker:"
  packer build tensorflow/tools/ci_build/buildkite/packer/linux-container.json
else
  echo "Docker config not changed, no updates necessary"
fi

