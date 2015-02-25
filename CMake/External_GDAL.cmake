message(STATUS "Setup GDAL...")

set(proj GDAL)
SETUP_SUPERBUILD(PROJECT ${proj})

if(UNIX)
  ExternalProject_Add(${proj}
    PREFIX ${proj}
    URL "http://download.osgeo.org/gdal/1.11.0/gdal-1.11.0.tar.gz"
    URL_MD5 9fdf0f2371a3e9863d83e69951c71ec4
    BINARY_DIR ${GDAL_SB_BUILD_DIR}
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    DEPENDS "EXPAT;LIBKML;GEOTIFF;OPENJPEG"
    UPDATE_COMMAND  ${CMAKE_COMMAND} -E copy_directory ${GDAL_SB_SRC} ${GDAL_SB_BUILD_DIR}
    PATCH_COMMAND ${CMAKE_COMMAND} -E touch ${GDAL_SB_SRC}/config.rpath      
    CONFIGURE_COMMAND 
      # use 'env' because CTest launcher doesn't perform shell interpretation
      env ${LDLIBVAR}=${CMAKE_INSTALL_PREFIX}/lib 
      ${GDAL_SB_BUILD_DIR}/configure 
      --prefix=${CMAKE_INSTALL_PREFIX}
      --enable-static=no
      --without-ogdi
      --without-jasper
      --with-libtiff=${ANACONDA_ROOT}
      --with-png=${ANACONDA_ROOT}
      --with-jpeg=${ANACONDA_ROOT}
      --with-sqlite3=${ANACONDA_ROOT}
      --with-geos=${ANACONDA_ROOT}
      --with-libz=${ANACONDA_ROOT}
      --with-curl=${ANACONDA_ROOT}
      --with-hdf5=${ANACONDA_ROOT}
      --with-netcdf=${ANACONDA_ROOT}
      --with-python=${ANACONDA_ROOT}/bin/python2
      --with-expat=${CMAKE_INSTALL_PREFIX}
      --with-libkml=${CMAKE_INSTALL_PREFIX}
      --with-geotiff=${CMAKE_INSTALL_PREFIX}
      --with-openjpeg=${CMAKE_INSTALL_PREFIX}
    BUILD_COMMAND $(MAKE)
    INSTALL_COMMAND $(MAKE) install
  )

else()
  message(FATAL_ERROR "GDAL build on windows is not yet supported")
endif()
