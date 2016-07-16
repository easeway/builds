#!/bin/bash

set -ex

TARGET_OS="$1"
TARGET_ARCH="$2"

SRCDIR=build/src/go/src/github.com/coreos/flannel
OUTDIR=$HMAKE_PROJECT_DIR/build/out/$TARGET_OS/$TARGET_ARCH
export GOPATH=$HMAKE_PROJECT_DIR/build/src/go
export PATH=/go/bin:/usr/local/go/bin:$PATH

mkdir -p $OUTDIR
cd $SRCDIR

GOOS=$TARGET_OS GOARCH=$TARGET_ARCH GOARM=7 CGO_ENABLED=1 \
    go build -o $OUTDIR/flanneld \
	  -ldflags "-extldflags -static -X github.com/coreos/flannel/version.Version=$(git describe --dirty)" \
      .
