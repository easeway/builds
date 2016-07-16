#!/bin/bash

set -ex

TARGET=${HMAKE_TARGET#*-}
SRCDIR=$HMAKE_PROJECT_DIR/build/src/linux
test -z "$KERNEL_VERSION" || SRCDIR=$SRCDIR-$KERNEL_VERSION

ARGS=""
ARGS_END=

for a in "$@"; do
    if [ -z "$ARGS_END" ]; then
        case "$a" in
        --)
            ARGS_END=yes
            continue
            ;;
        -*)
            ARGS="$ARGS $a"
            continue
            ;;
        *)
            ARGS_END=yes
            ;;
        esac
    fi
    patch -d "$SRCDIR" $ARGS <"$a"
done
