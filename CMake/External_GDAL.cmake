message(STATUS "Setup GDAL...")

set(proj GDAL)
SETUP_SUPERBUILD(PROJECT ${proj})

if(UNIX)

  configure_file(
    CMake/gdal_install_step.cmake.in
    ${CMAKE_CURRENT_BINARY_DIR}/gdal_install_step.cmake
    @ONLY)

  ExternalProject_Add(${proj}
    PREFIX ${proj}
    URL "http://download.osgeo.org/gdal/1.11.0/gdal-1.11.0.tar.gz"
    URL_MD5 9fdf0f2371a3e9863d83e69951c71ec4
    BINARY_DIR ${GDAL_SB_BUILD_DIR}
    INSTALL_DIR ${INSTALL_STAGING}
    DEPENDS "EXPAT;LIBKML;GEOTIFF;OPENJPEG"
    UPDATE_COMMAND  ${CMAKE_COMMAND} -E copy_directory ${GDAL_SB_SRC} ${GDAL_SB_BUILD_DIR}
    PATCH_COMMAND ${CMAKE_COMMAND} -E touch ${GDAL_SB_SRC}/config.rpath      
    CONFIGURE_COMMAND 
      # use 'env' because CTest launcher doesn't perform shell interpretation
      env ${LDLIBVAR}=${INSTALL_STAGING}/lib 
      ${GDAL_SB_BUILD_DIR}/configure
      --prefix=/
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
      --with-expat=${INSTALL_STAGING}
      --with-libkml=${INSTALL_STAGING}
      --with-geotiff=${INSTALL_STAGING}
      --with-openjpeg=${INSTALL_STAGING}
    BUILD_COMMAND $(MAKE)
    INSTALL_COMMAND ${CMAKE_COMMAND} -P ${CMAKE_CURRENT_BINARY_DIR}/gdal_install_step.cmake
  )

else()
  message(FATAL_ERROR "GDAL build on windows is not yet supported")
endif()
