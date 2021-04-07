#!/bin/bash

[[ " $* " =~ " --du " ]] && SHOW_DU=true

echo "=== PODS ==="
echo
kubectl get pod

echo
echo "=== PVCs ==="
echo
kubectl get pvc -o custom-columns=NAME:.metadata.name,STATUS:.status.phase,STORAGE-CLASS:.spec.storageClassName

echo
echo "=== Replications ==="
echo
kubectl get replicationdestination
kubectl get replicationsources

echo
echo "=== DATA ==="
echo
minikube ssh -- \
  sudo find /var/lib/kubelet/pods \
  -name counter.yaml \
  -exec 'head -1 {} \;' \
  -printf '\\n%p\\n\\n' \
  || echo "???"

echo "=== SHARED ==="
echo
minikube ssh -- \
  sudo find /tmp/testapp_shared \
    -name counter.yaml \
    -exec 'head -1 {} \;' \
    -printf '\\n%p\\n\\n' \
    || echo "???"

if [ "$SHOW_DU" == "true" ]
then
    echo
    echo "=== DISK USAGE ==="
    echo

    minikube ssh -- sudo du -sh /var/lib/kubelet/ || echo "???"
fi
