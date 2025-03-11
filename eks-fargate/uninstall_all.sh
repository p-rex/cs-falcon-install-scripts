#!/bin/bash -x

# To check helm release, run "helm list -n NAMESPACE"

# Falcon ensor
helm uninstall falcon-helm -n falcon-system
kubectl delete ns falcon-system
eksctl delete fargateprofile fp-falcon-system --cluster $FALCON_K8S_CLUSTER_NAME

# KAC
helm uninstall falcon-kac -n falcon-kac
kubectl delete ns falcon-kac
eksctl delete fargateprofile fp-falcon-kac --cluster $FALCON_K8S_CLUSTER_NAME

# IAR
helm uninstall falcon-image-analyzer -n falcon-image-analyzer
kubectl delete ns falcon-image-analyzer
eksctl delete fargateprofile fp-falcon-image-analyzer --cluster $FALCON_K8S_CLUSTER_NAME

# Remove helm repogitory
helm repo remove crowdstrike

