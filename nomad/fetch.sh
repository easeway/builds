#!/bin/bash

set -ex

SRCDIR=build/src/go/src/github.com/hashicorp/nomad

export GOPATH=$HMAKE_PROJECT_DIR/build/src/go
export PATH=/go/bin:/usr/local/go/bin:$PATH

rm -fr $SRCDIR
mkdir -p $(dirname $SRCDIR)

git clone --depth=1 https://github.com/hashicorp/nomad -b v0.4.0 $SRCDIR

cd $SRCDIR

# Get the rest of the deps
#DEPS=$(go list -f '{{range .TestImports}}{{.}} {{end}}' ./...)
#if [ -n "$DEPS" ]; then
#    go get -v ./... $DEPS
#fi

go generate $(go list ./... | grep -v /vendor/)
sed -i -e 's|github.com/hashicorp/nomad/vendor/github.com/ugorji/go/codec|github.com/ugorji/go/codec|' nomad/structs/structs.generated.go
