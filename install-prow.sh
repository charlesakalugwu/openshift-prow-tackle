#!/usr/bin/env bash

# run the following as customer-admin

# openssl rand -hex 20 > /path/to/hook/secret
kubectl create secret generic hmac-token --from-file=hmac=hmac_token

# https://github.com/settings/tokens
kubectl create secret generic oauth-token --from-file=oauth=github_token

# install the aro prow starter
oc apply -f cluster/aro/starter.yaml

# wait for deployments to be ready
kubectl wait --for=condition=available --timeout=60s \
	deployment/statusreconciler \
	deployment/hook \
	deployment/plank \
	deployment/deck \
	deployment/horologium \
	deployment/tide

