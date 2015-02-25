# gdal-anaconda
CMake "Superbuild" project to build GDAL for the Anaconda distribution

gdal-anaconda provides a CMake project to build GDAL for Anaconda.

It is primarily developed to ease the installation of Sen2Cor, the Sentinel 2 atmospheric
correction module of the Sentinel 2 Toolbox.

Sen2Cor standard installation procedure requires Anaconda, with the GDAL Python module,
GDAL being built with the OpenJPEG driver.
As this can be quite painful to get built.

To use this project, install ```cmake``` and 
```
$ export ANACONDA_ROOT=</path/to/anaconda>

$ export PATH=$ANACONDA_ROOT/bin

$ git clone https://github.com/senbox-org/gdal-anaconda

$ cd gdal-anaconda

$ mkdir build

$ cd build

$ cmake .. -DCMAKE_INSTALL_PREFIX=$ANACONDA_ROOT
```

This project is published under GPL-3.0
