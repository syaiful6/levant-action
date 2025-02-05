#!/usr/bin/env bash
set -e

BRANCH=$(echo $GITHUB_REF | rev | cut -d\/ -f1 | rev)
echo "deploy -var-file $LEVANT_VAR_FILE $NOMAD_JOB"

if [[ -z "${LEVANT_VAR_FILE}" ]]; then
  levant deploy -log-level=debug -ignore-no-changes "$NOMAD_JOB"
else
  levant deploy -var-file "$LEVANT_VAR_FILE" -log-level=debug -ignore-no-changes "$NOMAD_JOB"
fi
