#!/bin/bash
kubeconfig=$1
NS=$2
VAL=$3
export KUBECONFIG=$kubeconfig
kubectl create ns $NS
kubectl -n $NS create secret docker-registry docker --docker-server=hub-pub.jdcloud.com --docker-username=jrwangwei3 --docker-password=Jmsf1234 --docker-email=jrwangwei3@jd.com
helm --kubeconfig=$1 install consul consul-helm-v0.32.1.tgz -n $NS -f $VAL
# token的查看
token=$(kubectl  get secret -n $NS consul-consul-bootstrap-acl-token -o=jsonpath='{.data.token}' | base64 -d)
echo "token: $token"