message(STATUS "Setup Boost ...")

set(proj BOOST)
SETUP_SUPERBUILD(PROJECT ${proj})

ExternalProject_Add(${proj}
  PREFIX ${proj}
  URL "http://sourceforge.net/projects/boost/files/boost-binaries/1.50.0/boost_1_50_headers.zip/download"
  URL_MD5 1605dc6085cb2dc778ef5ab6c0e59083
  SOURCE_DIR ${BOOST_SB_SRC}/include/boost
  CONFIGURE_COMMAND ""
  BUILD_COMMAND ""
  INSTALL_COMMAND ${CMAKE_COMMAND} -E copy_directory ${BOOST_SB_SRC}/include/ ${INSTALL_STAGING}/include/
)
