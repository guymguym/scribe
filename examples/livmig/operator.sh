#!/bin/bash

[[ " $* " =~ " --helm " ]] && USE_HELM=true

if [ "$USE_HELM" == "true" ]
then
  echo
  echo "=== setup: install scribe with helm ==="
  echo

  helm repo add backube https://backube.github.io/helm-charts/
  helm install --create-namespace -n scribe-system scribe backube/scribe
  helm list -n scribe-system
else
  echo
  echo "=== setup: install scribe CRDs ==="
  echo
  make -C ../ install

  echo
  echo "=== setup: running scribe locally ==="
  echo
  make -C ../ run
fi
