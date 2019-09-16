#!/bin/bash

set -exo pipefail

PACKER_TARGET=$1

echo "$BUILDKITE_AGENT_TOKEN" | cut -c1-5

if git diff --name-only @~..@ | grep tensorflow/tools/ci_build/buildkite/packer/$PACKER_TARGET; then
  echo "+++ :packer:"
  cd tensorflow/tools/ci_build/buildkite/packer/
  packer build $PACKER_TARGET.json
else
  echo "Image config not changed, no updates necessary"
fi
