#!/bin/bash

echo $(dirname $0)

ANACONDA_ROOT=$HOME/dev/src/senbox/tools/anaconda-2.1.0-py27
GDAL_ANACONDA=$HOME/dev/src/senbox/tools/gdal/gdal-anaconda-src
GDAL_BUILD=$GDAL_ANACONDA/build
GDAL_INSTALL=$GDAL_ANACONDA/install

[ -d $GDAL_INSTALL ] && rm -rf $GDAL_INSTALL
[ -d $GDAL_BUILD ] && rm -rf $GDAL_BUILD
mkdir $GDAL_BUILD
mkdir $GDAL_INSTALL
cd $GDAL_BUILD
cmake $GDAL_ANACONDA \
  -DANACONDA_CONDA=$ANACONDA_ROOT/bin/conda \
  -DCMAKE_INSTALL_PREFIX=$GDAL_INSTALL
make -j3
