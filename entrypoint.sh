#!/usr/bin/env bash
set -e

NOMAD_IP_ADDR=${NOMAD_IP_ADDR:-"127.0.0.1"}

BRANCH=$(echo $GITHUB_REF | rev | cut -d\/ -f1 | rev)
echo "deploy -var-file $LEVANT_VAR_FILE $NOMAD_JOB"

if [[ ! -z ${SSH_PRIVATE_KEY+x} ]]; then
  # setup tunnel
  mkdir -p ~/.ssh
  ssh-keyscan -H "$NOMAD_IP_SERVER" >> ~/.ssh/known_hosts
  echo "$SSH_PRIVATE_KEY" >> id_rsa
  chmod 600 ./id_rsa

  ssh -4 -f -N -g -o StrictHostKeyChecking=no -o IdentitiesOnly=yes -i ./id_rsa -L 4646:$NOMAD_IP_ADDR:4646 root@$NOMAD_IP_SERVER
fi

if [[ -z "${LEVANT_VAR_FILE}" ]]; then
  levant deploy -log-level=debug -ignore-no-changes "$NOMAD_JOB"
else
  levant deploy -var-file "$LEVANT_VAR_FILE" -log-level=debug -ignore-no-changes "$NOMAD_JOB"
fi
