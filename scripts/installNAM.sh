#!/bin/sh
sudo helm repo update
sudo helm pull --untar --version 0.1.0 access-manager-charts/access-manager
sudo helm install --namespace automation access-manager access-manager --set global.amconfig.adminConsoleIP=164.99.91.118 --set global.amsecret.adminName=admin --set global.amsecret.adminPassword=novell --set am-ac.node=ubuntu-machine --set global.image.repository=security-accessmanager-docker.btpartifactory.swinfra.net
