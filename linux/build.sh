#!/bin/bash

TARGET=${HMAKE_TARGET#*-}
SRCDIR=$HMAKE_PROJECT_DIR/build/src/linux
OUTDIR=$HMAKE_PROJECT_DIR/build/out/$TARGET

test -z "$KERNEL_VERSION" || SRCDIR=$SRCDIR-$KERNEL_VERSION

fatal() {
    echo "$@" >&2
    exit 1
}

oldconfig() {
    local arch=$1 cf=$2
    mkdir -p $OUTDIR
    if [ -f config ]; then
        make -C $SRCDIR O=$OUTDIR V=1 defconfig
        cp -f config $OUTDIR/.config
        make -C $OUTDIR ARCH=$arch oldconfig V=1
    else
        ARCH=$arch make -C $SRCDIR O=$OUTDIR V=1 $cf
    fi
}

build_make() {
    local arch=$1 cross=$2
    shift; shift
    LOCALVERSION= make -C $OUTDIR ARCH=$arch CROSS_COMPILE=$cross V=1 $MAKE_BUILD_OPTS $@
}

build() {
    build_make $1 $2 all
}

install() {
    build_make $@ INSTALL_MOD_PATH=$OUTDIR/modules modules_install firmware_install
}

config() {
    TARGET=config
    OUTDIR=$HMAKE_PROJECT_DIR/build/out/$TARGET
    mkdir -p $OUTDIR
    make -C $SRCDIR O=$OUTDIR V=1 $@
}

clean() {
    rm -fr $OUTDIR
}

set -ex

cmd="$1"
shift
case "$cmd" in
    oldconfig) oldconfig $@ ;;
    make) build_make $@ ;;
    build) build $@ ;;
    install) install $@ ;;
    clean) clean ;;
    config) config $@ ;;
    *) fatal "bad command" ;;
esac
