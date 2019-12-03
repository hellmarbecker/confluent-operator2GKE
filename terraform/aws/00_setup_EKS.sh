#!/usr/bin/env bash

set -e

terraform output kubeconfig >> ~/.kube/config

echo "Provisioning K8s cluster..."
eksctl get cluster
eksctl get nodegroup
eksctl get iamserviceaccount 
eksctl get iamidentitymapping

# _idempotent_ setup

until kubectl cluster-info >/dev/null 2>&1; do
    echo "kubeapi not available yet..."
    sleep 3
done
# Make tiller a cluster-admin so it can do whatever it wants
kubectl apply -f tiller-rbac.yaml

helm init --wait --service-account tiller
# This supposedly helps with flaky "lost connection to pod" errors and the like when installing a chart
kubectl set resources -n kube-system deployment tiller-deploy --limits=memory=200Mi

# Create eksadmin service account
kubectl apply -f eks-admin-service-account.yaml

echo " EKS cluster created"
eksctl get cluster