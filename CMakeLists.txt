cmake_minimum_required(VERSION 2.8.3)
project(gdal-anaconda)

# Path to additional CMake modules
set(CMAKE_MODULE_PATH
    ${CMAKE_SOURCE_DIR}/CMake
    ${CMAKE_MODULE_PATH})

find_package(Anaconda
  3.9
  REQUIRED
  COMPONENTS libpng libtiff jpeg zlib curl geos sqlite hdf5 python netcdf4
  )

set(CMAKE_PREFIX_PATH ${ANACONDA_ROOT} ${CMAKE_PREFIX_PATH})

include(CTest)
include(ExternalProject)
include(CMakeParseArguments)

# Initialize usefull variables to build a superbuild project
macro(SETUP_SUPERBUILD)
  cmake_parse_arguments(NEW_SB "" "PROJECT" "" ${ARGN})
  set(${NEW_SB_PROJECT}_DEPENDENCIES "")
  set(${NEW_SB_PROJECT}_SB_BUILD_DIR ${CMAKE_BINARY_DIR}/${NEW_SB_PROJECT}/build)
  set(${NEW_SB_PROJECT}_SB_SRC ${CMAKE_BINARY_DIR}/${NEW_SB_PROJECT}/src/${NEW_SB_PROJECT})
  set(${NEW_SB_PROJECT}_SB_CONFIG "")
endmacro(SETUP_SUPERBUILD)

if(WIN32)
  if(MSVC)
    set(SB_CMAKE_COMMAND ${CMAKE_COMMAND})
  endif()      
else(UNIX)
  if(APPLE)
    set(LDLIBVAR DYLD_LIBRARY_PATH)
  else()
    set(LDLIBVAR LD_LIBRARY_PATH)
  endif()
  set(SB_CMAKE_COMMAND env ${LDLIBVAR}=${CMAKE_INSTALL_PREFIX}/lib  ${CMAKE_COMMAND})
endif()

# Call external projects
include(External_boost)
include(External_proj4)
include(External_geotiff)
include(External_expat)
include(External_libKML)
include(External_OpenJpeg)
#include(External_pcre)
#include(External_swig)
include(External_GDAL)
