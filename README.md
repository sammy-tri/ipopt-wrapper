# ipopt-wrapper

Compilation scripts to checkout and build IPOPT for use with Drake.

This wrapper exists primarily because IPOPT uses subversion (with
heavy use of externals) as their primary distribution channel, and
integrating that into Drake directly (along with a binary download for
Windows builds) seemed like an excessive amount of complication to
live in Drake's top-level CMakeLists.txt.

Note about using IPOPT with MATLAB (Linux specific):

When compiling IPOPT for use in libraries which may later be used as
part of a MATLAB mex module, some complications arise, as IPOPT
compiles BLAS as part of it's build process (and integrates the
resulting library), and MATLAB provides an alternate implementation of
BLAS with the same symbols and an incompatible ABI.

This issue is referenced in the IPOPT documentation: http://www.coin-or.org/Ipopt/documentation/node18.html

Our IPOPT build follows these instructions, thought an additional
caveat is that when linking the resulting PIC .a library into another
.so, -Bsymbolic needs to be passed as a linker flag to ensure that
IPOPT only references its local BLAS symbols.