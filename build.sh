#!/bin/sh

# Download and build IPOPT from their SVN repository.

set -e

CMAKE_INSTALL_PREFIX=$1

svn checkout --non-interactive --trust-server-cert https://projects.coin-or.org/svn/Ipopt/stable/3.12 .

ORIG_PWD=$PWD
for i in ThirdParty/*; do
    GET_SCRIPT_NAME=./get.`echo $i | cut -d / -f 2;`
    cd $i
    if [ -x $GET_SCRIPT_NAME ]; then
	$GET_SCRIPT_NAME
    fi
    cd $ORIG_PWD
done


# IPOPT's build system sets -pedantic-errors when building with clang
# on linux, which makes it's autoconf script fail tests which should
# pass.  Sigh.
if [ "$BUILD_TYPE" = "Debug" ]; then
    CFLAGS="-g -O0"
    CXXFLAGS="-g -O0"
else
    CFLAGS="-O3"
    CXXFLAGS="-O3"
fi
export CFLAGS
export CXXFLAGS

./configure  --with-blas=BUILD --with-lapack=BUILD --prefix=${CMAKE_INSTALL_PREFIX} --includedir=${CMAKE_INSTALL_PREFIX}/include/nlopt
make install
