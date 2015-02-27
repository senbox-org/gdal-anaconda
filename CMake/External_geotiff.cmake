message(STATUS "Setup libgeotiff...")

set(proj GEOTIFF)
SETUP_SUPERBUILD(PROJECT ${proj})

if(MSVC)
  list(APPEND GEOTIFF_SB_CONFIG
    -DCMAKE_PREFIX_PATH:STRING=${INSTALL_STAGING};${ANACONDA_ROOT})
else()
  list(APPEND GEOTIFF_SB_CONFIG
    --with-libtiff=${ANACONDA_ROOT}
    --with-jpeg=${ANACONDA_ROOT}
    --with-proj=${INSTALL_STAGING}
    )
endif()

if(MSVC)
  ExternalProject_Add(${proj}
    PREFIX ${proj}
    URL "http://download.osgeo.org/geotiff/libgeotiff/libgeotiff-1.4.0.tar.gz"
    URL_MD5 efa7b418bc00228fcda4da63557e40c2
    BINARY_DIR ${GEOTIFF_SB_BUILD_DIR}
    INSTALL_DIR ${INSTALL_STAGING}
    DEPENDS "PROJ"
    PATCH_COMMAND ${CMAKE_COMMAND} -E copy 
      ${CMAKE_SOURCE_DIR}/patches/${proj}/CMakeLists.txt
      ${GEOTIFF_SB_SRC}  
    
    CMAKE_CACHE_ARGS
      -DCMAKE_INSTALL_PREFIX:STRING=${INSTALL_STAGING}
      -DCMAKE_BUILD_TYPE:STRING=Release
      -DWITH_TIFF:BOOL=ON
      -DWITH_PROJ4:BOOL=ON
      -DWITH_JPEG:BOOL=OFF
      -DWITH_ZLIB:BOOL=ON
      -DWITH_UTILITIES:BOOL=ON
      ${GEOTIFF_SB_CONFIG}
    )
else()
  ExternalProject_Add(${proj}
    PREFIX ${proj}
    URL "http://download.osgeo.org/geotiff/libgeotiff/libgeotiff-1.4.0.tar.gz"
    URL_MD5 efa7b418bc00228fcda4da63557e40c2
    BINARY_DIR ${GEOTIFF_SB_BUILD_DIR}
    INSTALL_DIR ${INSTALL_STAGING}
    CONFIGURE_COMMAND
      # use 'env' because CTest launcher doesn't perform shell interpretation
      env ${LDLIBVAR}=${INSTALL_STAGING}/lib
      ${GEOTIFF_SB_BUILD_DIR}/configure
      --prefix=${INSTALL_STAGING}
      --enable-static=no
      ${GEOTIFF_SB_CONFIG}
    BUILD_COMMAND $(MAKE)
    INSTALL_COMMAND $(MAKE) install
    DEPENDS "PROJ"
    PATCH_COMMAND ${CMAKE_COMMAND} -E copy 
      ${CMAKE_SOURCE_DIR}/patches/${proj}/configure
      ${GEOTIFF_SB_SRC}
    )
  ExternalProject_Add_Step(${proj} copy_source
    COMMAND ${CMAKE_COMMAND} -E copy_directory 
      ${GEOTIFF_SB_SRC} ${GEOTIFF_SB_BUILD_DIR}
    DEPENDEES patch update
    DEPENDERS configure
    )
endif()
