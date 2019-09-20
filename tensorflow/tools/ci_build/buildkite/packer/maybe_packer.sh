#!/bin/bash

set -exo pipefail

PACKER_TARGET=$1

echo "$GCP_PROJECT_ID"
echo "$ANOTHER_ENV_PARAM"
echo "$BUILDKITE_AGENT_TOKEN" | cut -c1-5
echo "$BTOK" | cut -c1-5

if git diff --name-only @~..@ | grep tensorflow/tools/ci_build/buildkite/packer/$PACKER_TARGET; then
  echo "+++ :packer:"
  cd tensorflow/tools/ci_build/buildkite/packer/
  packer build $PACKER_TARGET.json
else
  echo "Image config not changed, no updates necessary"
fi
