#!/bin/bash -x

# To check helm release, run "helm list -n NAMESPACE"

# Falcon sensor
helm uninstall falcon-sensor -n falcon-system
kubectl delete ns falcon-system

# KAC
helm uninstall falcon-kac -n falcon-kac
kubectl delete ns falcon-kac

# IAR
helm uninstall falcon-image-analyzer -n falcon-image-analyzer
kubectl delete ns falcon-image-analyzer

# Remove helm repogitory
helm repo remove crowdstrike

