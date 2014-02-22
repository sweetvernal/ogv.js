#!/bin/bash

# configure libogg
dir=`pwd`
cd libogg
if [ ! -f configure ]; then
  # generate configuration script
  sed -i.bak 's/$srcdir\/configure/#/' autogen.sh
  ./autogen.sh
  
  # -O20 and -04 cause problems
  # see https://github.com/kripken/emscripten/issues/264
  sed -i.bak 's/-O20/-O2/g' configure
  sed -i.bak 's/-O4/-O2/g' configure
fi
cd ..

# set up the build directory
mkdir build
cd build

mkdir root
mkdir libogg
cd libogg

# finally, run configuration script
emconfigure ../../libogg/configure --prefix="$dir/build/root" --disable-shared

# compile libogg
emmake make
emmake make install

cd ..
cd ..

