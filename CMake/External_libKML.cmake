message(STATUS "Setup libKML ...")

set(proj LIBKML)
SETUP_SUPERBUILD(PROJECT ${proj})

ExternalProject_Add(${proj}
  PREFIX ${proj}
  URL "http://ftp.de.debian.org/debian/pool/main/libk/libkml/libkml_1.3.0~r863.orig.tar.gz"
  URL_MD5 211ed5fdf2dd45aeb9c0abc8e1fe42be
  BINARY_DIR ${LIBKML_SB_BUILD_DIR}
  INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
  DEPENDS "EXPAT;BOOST"
  PATCH_COMMAND ${CMAKE_COMMAND} -E copy_directory  ${CMAKE_SOURCE_DIR}/patches/${proj} ${LIBKML_SB_SRC}    
  CMAKE_CACHE_ARGS
    -DCMAKE_INSTALL_PREFIX:STRING=${CMAKE_INSTALL_PREFIX}
    -DCMAKE_BUILD_TYPE:STRING=Release
    -DBUILD_SHARED_LIBS:BOOL=ON
    -DCMAKE_PREFIX_PATH:STRING=${CMAKE_INSTALL_PREFIX};${CMAKE_PREFIX_PATH}
  )

if(FALSE)
ExternalProject_Add(${proj}
  PREFIX ${proj}
  URL "http://ftp.de.debian.org/debian/pool/main/libk/libkml/libkml_1.3.0~r863.orig.tar.gz"
  URL_MD5 211ed5fdf2dd45aeb9c0abc8e1fe42be
  BINARY_DIR ${LIBKML_SB_BUILD_DIR}
  INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
  DEPENDS "EXPAT;BOOST"
  PATCH_COMMAND ${CMAKE_COMMAND} -E copy_directory  ${CMAKE_SOURCE_DIR}/patches/${proj} ${LIBKML_SB_SRC}    
  UPDATE_COMMAND  ${CMAKE_COMMAND} -E copy_directory ${LIBKML_SB_SRC} ${LIBKML_SB_BUILD_DIR}
  CONFIGURE_COMMAND env ${LDLIBVAR}=${CMAKE_INSTALL_PREFIX}/lib
      ${LIBKML_SB_BUILD_DIR}/configure
      --prefix=${CMAKE_INSTALL_PREFIX}
      --with-expat-include-dir=${CMAKE_INSTALL_PREFIX}/include
      --with-expat-lib-dir=${CMAKE_INSTALL_PREFIX}/lib
  BUILD_COMMAND $(MAKE)
  INSTALL_COMMAND $(MAKE) install
  )
endif()
