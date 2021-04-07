#!/bin/bash

echo
echo "=== start: setup namespace ==="
echo

if ! kubectl create ns livmig
then
  echo
  echo "WARNING: namespace livmig already exists"
  echo "         (you can use --delete or --delete-ns to start from fresh)"
  echo
fi

kubectl config set-context --current --namespace livmig

echo
echo "=== start: build image ==="
echo

eval $(minikube docker-env)
docker build -t livmig app/

echo
echo "=== start: deploy app ==="
echo

kubectl apply -f app/app.yaml
kubectl delete pod -l app=testapp --now

echo
echo "=== start: done ==="
echo
