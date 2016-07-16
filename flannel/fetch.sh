#!/bin/bash

set -ex

SRCDIR=build/src/go/src/github.com/coreos/flannel

export GOPATH=$HMAKE_PROJECT_DIR/build/src/go
export PATH=/go/bin:/usr/local/go/bin:$PATH

rm -fr $SRCDIR
mkdir -p $(dirname $SRCDIR)

git clone --depth=1 https://github.com/coreos/flannel -b v0.5.5 $SRCDIR
