#!/bin/sh

# Download and build IPOPT from their SVN repository.

set -e

CMAKE_INSTALL_PREFIX=$1

svn checkout https://projects.coin-or.org/svn/Ipopt/stable/3.12 .

ORIG_PWD=$PWD
for i in ThirdParty/*; do
    GET_SCRIPT_NAME=./get.`echo $i | cut -d / -f 2;`
    cd $i
    if [ -x $GET_SCRIPT_NAME ]; then
	$GET_SCRIPT_NAME
    fi
    cd $ORIG_PWD
done

./configure  --with-blas=BUILD --with-lapack=BUILD --prefix=${CMAKE_INSTALL_PREFIX} --includedir=${CMAKE_INSTALL_PREFIX}/include/nlopt
make install
