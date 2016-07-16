#!/bin/bash

set -ex

curl -sSL https://storage.googleapis.com/golang/go1.6.2.linux-amd64.tar.gz | tar -C /usr/local -zx
apt-get -y install zip
mkdir -p /go

export GOPATH=/go
export PATH=$GOPATH/bin:/usr/local/go/bin:$PATH
