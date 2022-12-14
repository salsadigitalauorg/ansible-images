#!/bin/bash
set -eu

./config.sh \
  --url https://github.com/salsadigitalauorg/ansible-images \
  --token ${RUNNER_TOKEN}

exec "/actions-runner/run.sh"
