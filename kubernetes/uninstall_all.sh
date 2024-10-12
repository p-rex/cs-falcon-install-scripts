#!/bin/bash -x

#######################################################
# Load functions
source <(curl -s https://raw.githubusercontent.com/p-rex/cs-falcon-install-scripts/refs/heads/main/kubernetes/functions.sh)


#######################################################
# Check prerequisite
check_command "curl"
check_command "jq"
check_command "helm"
check_command "kubectl"


#######################################################
# Uninstall sensor

# Sensor
helm uninstall falcon-helm -n $FALCON_NAMESPACE
# Naamesapace
kubectl delete ns falcon-system
