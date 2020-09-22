#!/bin/sh
sudo rm -r /mnt/am-ac
sudo rm -r /mnt/am-edir
sudo rm -r /mnt/am-idp
sudo rm -r /mnt/am-ag

docker rmi $( docker images | grep am- | awk '{print $3}')
