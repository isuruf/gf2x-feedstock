#!/usr/bin/env bash

chmod +x configure

export CFLAGS="-O2 -g $CFLAGS"

case `uname` in
    Darwin|Linux)
        ./configure --prefix="$PREFIX" --libdir="$PREFIX"/lib --disable-hardware-specific-code
        ;;
    MINGW*)
        export PATH="$PREFIX/Library/bin:$BUILD_PREFIX/Library/bin:$PATH"
        export CC=clang-cl
        export RANLIB=llvm-ranlib
        export AS=llvm-as
        export AR=llvm-ar
        export LD=lld-link
        export CFLAGS="-MD -I$PREFIX/Library/include -O2"
        export LDFLAGS="$LDFLAGS -link -L$PREFIX/Library/lib"
        clang --version
        llvm-as --version
        llvm-ar --version
        ./configure --prefix="$PREFIX/Library" --libdir="$PREFIX/Library/lib" --disable-hardware-specific-code
        ;;
esac


make
make check
make install
