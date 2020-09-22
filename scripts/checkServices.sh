#!/bin/bash
counter=0
statusAC=`kubectl exec access-manager-am-ac-0 -c am-ac -n automation -- /etc/init.d/novell-ac status`
if [[ $statusAC == *"running"* ]];then
	counter=$((counter+1))
	echo $counter
	echo "AC status -" $statusAC
else
	echo "AC service not up!"
fi

statusIDP=`kubectl exec access-manager-am-idp-0 -n automation -- /etc/init.d/novell-idp status`
if [[ $statusIDP == *"running"* ]];then
        counter=$((counter+1))
        echo $counter
	echo "IDP status-" $statusIDP
else
        echo "IDP service not up!"
fi

echo "Total test cases passed-" $counter "/3"

#echo $status
