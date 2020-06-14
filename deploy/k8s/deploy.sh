#!/bin/bash

if [ $# = 0 ]; then
	echo "引数(API_SERVER_IMAGE_NAME)なし"
	exit 1
else
  export API_SERVER_IMAGE_NAME=$1
	cat load-balancer-example.tpl.yaml | ./extcat.sh > load-balancer-example.yaml
  kubectl apply -f load-balancer-example.yaml
fi


