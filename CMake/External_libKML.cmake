message(STATUS "Setup libKML ...")

set(proj LIBKML)
SETUP_SUPERBUILD(PROJECT ${proj})

ExternalProject_Add(${proj}
  PREFIX ${proj}
  URL "http://ftp.de.debian.org/debian/pool/main/libk/libkml/libkml_1.3.0~r863.orig.tar.gz"
  URL_MD5 211ed5fdf2dd45aeb9c0abc8e1fe42be
  BINARY_DIR ${LIBKML_SB_BUILD_DIR}
  INSTALL_DIR ${INSTALL_STAGING}
  DEPENDS "EXPAT;BOOST"
  PATCH_COMMAND ${CMAKE_COMMAND} -E copy_directory  ${CMAKE_SOURCE_DIR}/patches/${proj} ${LIBKML_SB_SRC}    
  CMAKE_CACHE_ARGS
    -DCMAKE_INSTALL_PREFIX:STRING=${INSTALL_STAGING}
    -DCMAKE_BUILD_TYPE:STRING=Release
    -DBUILD_SHARED_LIBS:BOOL=ON
    -DCMAKE_PREFIX_PATH:STRING=${INSTALL_STAGING};${CMAKE_PREFIX_PATH}
  )

if(FALSE)
ExternalProject_Add(${proj}
  PREFIX ${proj}
  URL "http://ftp.de.debian.org/debian/pool/main/libk/libkml/libkml_1.3.0~r863.orig.tar.gz"
  URL_MD5 211ed5fdf2dd45aeb9c0abc8e1fe42be
  BINARY_DIR ${LIBKML_SB_BUILD_DIR}
  INSTALL_DIR ${INSTALL_STAGING}
  DEPENDS "EXPAT;BOOST"
  PATCH_COMMAND ${CMAKE_COMMAND} -E copy_directory  ${CMAKE_SOURCE_DIR}/patches/${proj} ${LIBKML_SB_SRC}    
  UPDATE_COMMAND  ${CMAKE_COMMAND} -E copy_directory ${LIBKML_SB_SRC} ${LIBKML_SB_BUILD_DIR}
  CONFIGURE_COMMAND env ${LDLIBVAR}=${INSTALL_STAGING}/lib
      ${LIBKML_SB_BUILD_DIR}/configure
      --prefix=${INSTALL_STAGING}
      --with-expat-include-dir=${INSTALL_STAGING}/include
      --with-expat-lib-dir=${INSTALL_STAGING}/lib
  BUILD_COMMAND $(MAKE)
  INSTALL_COMMAND $(MAKE) install
  )
endif()
