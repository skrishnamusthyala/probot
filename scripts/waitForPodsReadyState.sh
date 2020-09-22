#!/bin/bash
#currentState=`kubectl wait --for=condition=Ready pod/access-manager-am-ac-0 -n automation|awk '{print $3}'`
#sleep 10
#currentState_AC="false"
#echo $currentState_AC

#while [ $currentState_AC != "met" ]
#do
kubectl wait --for=condition=Ready pod/access-manager-am-ac-0 --timeout=720s -n automation|awk '{print $3}'
#done
#echo $currentState_AC

#currentState_IDP="false"
#echo $currentState_IDP
#while [ $currentState_IDP != "met" ]
#do
kubectl wait --for=condition=Ready pod/access-manager-am-idp-0 --timeout=600s -n automation|awk '{print $3}'
#done
#echo $currentState_IDP

#currentState_AG="false"
#echo $currentState_AG
#while [ $currentState_AG != "met" ]
#do
#	echo $currentState_AG
kubectl wait --for=condition=Ready pod/access-manager-am-ag-0 --timeout=900s -n automation|awk '{print $3}'
#done
#echo $currentState_AG

