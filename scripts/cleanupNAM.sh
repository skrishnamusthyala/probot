#!/bin/sh

sudo helm uninstall --namespace automation access-manager
sudo kubectl delete --namespace=automation secret admin-credentials
sudo kubectl delete --namespace=automation configmap am-config
sudo kubectl delete --namespace=automation pvc $(kubectl get --namespace=automation pvc  | awk '{if(NR>1)print}' | cut -d" " -f1)
sudo kubectl delete pv $(kubectl get pv | grep automation | awk '{print $1}')

sudo rm -r /tmp/access-manager

sudo helm repo remove access-manager-charts

