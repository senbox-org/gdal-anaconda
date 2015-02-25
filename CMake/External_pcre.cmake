message(STATUS "Setup pcre...")

set(proj PCRE)
SETUP_SUPERBUILD(PROJECT ${proj})

if(UNIX)
  ExternalProject_Add(${proj}
    PREFIX ${proj}
    URL "http://sourceforge.net/projects/pcre/files/pcre/8.36/pcre-8.36.tar.gz/download"
    URL_MD5 ff7b4bb14e355f04885cf18ff4125c98
    BINARY_DIR ${PCRE_SB_BUILD_DIR}
    INSTALL_DIR ${CMAKE_INSTALL_PREFIX}
    UPDATE_COMMAND  ${CMAKE_COMMAND} -E copy_directory ${PCRE_SB_SRC} ${PCRE_SB_BUILD_DIR}
    CONFIGURE_COMMAND
      ${PCRE_SB_BUILD_DIR}/configure
      --prefix=${CMAKE_INSTALL_PREFIX}
      --disable-shared
    BUILD_COMMAND $(MAKE)
    INSTALL_COMMAND $(MAKE) install
    )

else()
  message(FATAL_ERROR "PCRE build is not yet implemented on Windows")    
endif()
