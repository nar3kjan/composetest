#!/bin/bash

az aks get-credentials --resource-group Greetings-rg --name Greetings-cluster

az aks create -g Greetings-rg -n Greetings-cluster --enable-managed-identity --nodepool-name frontendpool --node-count 1 --enable-addons monitoring --enable-msi-auth-for-monitoring  --generate-ssh-keys

az aks nodepool add --resource-group Greetings-rg --cluster-name Greetings-cluster --name backendpool --node-count 1

kubectl label nodes <your-node-name> pool=backend
kubectl label nodes <your-node-name> pool=frontend

kubectl create secret docker-registry regcred --docker-server=https://greetingsregistry.azurecr.io --docker-username=cb7868b7-4ec3-400d-84bf-b6348618b7ed --docker-password=O7j8Q~RJsksdtqmo4WW1t17iVeoZbtoxkrxFPb95