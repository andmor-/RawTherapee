#!/bin/bash

## 18-8-2021: Using libomp latest version from Homebrew causes an immediate crash when launching Rawtherapee
##We need to install an older version.
##Install libomp 11.1:
### brew unlink libomp
### curl -O https://raw.githubusercontent.com/Homebrew/homebrew-core/fb8323f2b170bd4ae97e1bac9bf3e2983af3fdb0/Formula/libomp.rb
### brew install ./libomp.rb

rm -rf build
mkdir -p build 

(cd build
cmake -DCMAKE_BUILD_TYPE="release" \
      -DLOCAL_PREFIX="$(brew --prefix)" \
      -DPROC_TARGET_NUMBER="2" \
      -DCODESIGNID="Apple Development: example@example.com (XXXXXXXXXX)" \
      -DOSX_DEV_BUILD="ON" \
      -DCACHE_NAME_SUFFIX="5.8-dev" \
      -DCMAKE_C_COMPILER="clang" \
      -DCMAKE_CXX_COMPILER="clang++" \
      -DWITH_LTO="ON" \
      -DLENSFUNDBDIR="../../lensfun/data/db/" \
      -DCMAKE_OSX_DEPLOYMENT_TARGET="11.3" \
      ..


make -j$(($(nproc)+1)) install
make macosx_bundle)
