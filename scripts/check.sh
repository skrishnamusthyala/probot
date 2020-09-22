#!/bin/sh
#sleep 10
result=`kubectl get pods,pv,pvc,statefulset -n automation | awk '{print $0}'`
if [[ "$result" =~ "No resource" ]];
 then
        echo "$result"
 else
        echo "Cleanup was not successful"
fi

