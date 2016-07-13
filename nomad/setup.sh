#!/bin/bash

set -ex

curl -sSL https://storage.googleapis.com/golang/go1.6.2.linux-amd64.tar.gz | tar -C /usr/local -zx
apt-get -y install zip
mkdir -p /go

export GOPATH=/go
export PATH=$GOPATH/bin:/usr/local/go/bin:$PATH

go get -v github.com/kardianos/govendor
go get -v github.com/mitchellh/gox
go get -v github.com/axw/gocov/gocov
go get -v gopkg.in/matm/v1/gocov-html
go get -v github.com/ugorji/go/codec/codecgen

GOOS=windows go get -v -d github.com/StackExchange/wmi
GOOS=windows go get -v -d github.com/shirou/w32
GOOS=linux go get -v -d github.com/docker/docker/pkg/mount
GOOS=linux go get -v -d github.com/opencontainers/runc/libcontainer/cgroups/fs
GOOS=linux go get -v -d github.com/opencontainers/runc/libcontainer/configs
GOOS=linux go get -v -d github.com/coreos/go-systemd/util
GOOS=linux go get -v -d github.com/coreos/go-systemd/dbus
