#!/bin/bash

set -e

if [ -z ${GOPATH} ]; then
    echo "\"GOPATH\" environmental variable is not set";
    exit 1
fi

if [ -z ${version} ]; then
    echo "\"version\" environmental variable is not set";
    exit 1
fi

cd $GOPATH

for binary_name in nuage-k8s-infra
do
    docker run --rm -v `pwd`:/go -w /go golang:1.8 go build -v -o $binary_name github.com/nuagenetworks/nuage-k8s-infra
    mv $binary_name $GOPATH/src/github.com/nuagenetworks/nuage-k8s-infra
done

cd $GOPATH/src/github.com/nuagenetworks/nuage-k8s-infra

sudo docker build -t nuage/infra:${version} .
docker save nuage/infra:${version} > nuage-infra-docker-${version}.tar
docker rmi nuage/infra:${version}
