#!/bin/bash

[[ " $* " =~ " --ns " ]] && DELETE_NS=true

if [ "$DELETE_NS" == "true" ]
then

  echo
  echo "=== cleanup: delete ns ==="
  echo

  kubectl delete ns livmig --now || echo "namespace livmig not found"

else

  echo
  echo "=== cleanup: testapp ..."
  echo

  kubectl delete -f app/app.yaml

  echo
  echo "=== cleanup: replications ..."
  echo

  kubectl delete --all replicationsources
  kubectl delete --all replicationdestinations

  echo
  echo "=== cleanup: PVCs and snapshots ..."
  echo

  kubectl delete --all pvc
  kubectl delete --all volumesnapshots

fi

echo
echo "=== cleanup: rm -rf /tmp/testapp_shared ..."
echo

minikube ssh -- sudo rm -rf /tmp/testapp_shared
minikube ssh -- sudo mkdir -p /tmp/testapp_shared

echo
echo "=== cleanup: done."
echo
