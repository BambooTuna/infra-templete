#!/bin/bash

if [ $# = 0 ]; then
	echo "引数(API_SERVER_IMAGE_NAME)なし"
	exit 1
else
  export MYSQL_NAMESPACE=mysql-service
  export PROMETHEUS_NAMESPACE=prometheus-service
  export GRAFANA_NAMESPACE=grafana-service

  export API_SERVER_IMAGE_NAME=$1
	cat apiServer.tpl.yaml | ./extcat.sh > apiServer.yaml
  kubectl apply -f apiServer.yaml

  helm upgrade --install ${MYSQL_NAMESPACE} -f ./helm/mysql/values.yaml stable/mysql
  helm upgrade --install ${PROMETHEUS_NAMESPACE} -f ./helm/prometheus/values.yaml stable/prometheus
  helm upgrade --install ${GRAFANA_NAMESPACE} -f ./helm/grafana/values.yaml stable/grafana


fi


