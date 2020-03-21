#!/usr/bin/env bash

echo "Status Services"

export KUBECONFIG=/etc/kubernetes/admin.conf

echo "Docker"
systemctl status docker | grep "Active:"
echo "K8s"
systemctl status kubelet | grep "Active:"

echo "Cluster Info"
kubectl cluster-info

echo "Get All"
kubectl get all --all-namespaces
