#!/usr/bin/env bash

chmod +x configure

export CFLAGS="-O2 -g $CFLAGS"

#TODO: Try building dll on windows

case `uname` in
    Darwin|Linux)
        ./configure --prefix="$PREFIX" --libdir="$PREFIX"/lib --disable-hardware-specific-code
        ;;
    MINGW*)
        export PATH="$PREFIX/Library/bin:$BUILD_PREFIX/Library/bin:$PATH"
        export CC=clang
        export RANLIB=llvm-ranlib
        export AS=llvm-as
        export AR=llvm-ar
        export CFLAGS="-MD -I$PREFIX/Library/include"
        export LDFLAGS="$LDFLAGS -L$PREFIX/Library/lib"
        clang --version
        llvm-as --version
        llvm-ar --version
        ./configure --prefix="$PREFIX/Library" --libdir="$PREFIX/Library/lib" --disable-hardware-specific-code
        ;;
esac


make
make check
make install
