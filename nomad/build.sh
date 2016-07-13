#!/bin/bash

set -ex

SRCDIR=build/src/go/src/github.com/hashicorp/nomad

export GOPATH=$HMAKE_PROJECT_DIR/build/src/go
export PATH=/go/bin:/usr/local/go/bin:$PATH

usage() {
    echo "./build.sh build <arch>"
    exit 2
}

build() {
    cd $SRCDIR

    export XC_OS=$1
    export XC_ARCH=$2
    export GOARM=7
    case "$XC_OS-$XC_ARCH" in
        linux-arm)
            TARGET_ARCH=arm
            ABI=gnueabihf
            ;;
        linux-amd64)
            TARGET_ARCH=x86_64
            ABI=gnu
            ;;
        *)
            echo "not supported $XC_OS-$XC_ARCH" >&2
            return 1
            ;;
    esac

    export CC_FOR_TARGET=${TARGET_ARCH}-${XC_OS}-$ABI-gcc
    export CXX_FOR_TARGET=${TARGET_ARCH}-${XC_OS}-$ABI-g++

    # GIT_COMMIT="$(git rev-parse HEAD)"
    # GIT_DIRTY="$(test -n "`git status --porcelain`" && echo "+CHANGES" || true)"
    #
    # gox -os="${XC_OS}" \
    #     -arch="${XC_ARCH}" \
    #     -ldflags "-X main.GitCommit='${GIT_COMMIT}${GIT_DIRTY}'" \
    #     -cgo \
    #     -output "pkg/{{.OS}}_{{.Arch}}/nomad" \
    #     .
    gox -os="${XC_OS}" \
        -arch="${XC_ARCH}" \
        -cgo \
        -output "pkg/{{.OS}}_{{.Arch}}/nomad" \
        .

    rm -fr $HMAKE_PROJECT_DIR/build/bin/${XC_OS}_${XC_ARCH}
    mkdir -p $HMAKE_PROJECT_DIR/build/bin/
    cp -rf pkg/${XC_OS}_${XC_ARCH} $HMAKE_PROJECT_DIR/build/bin
}

case "$1" in
    build) build $2 $3;;
    *) usage ;;
esac
