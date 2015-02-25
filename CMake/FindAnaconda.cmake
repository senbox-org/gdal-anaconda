# - Find Anaconda
# Find the Anaconda python distribution
#
# Inputs :
#   ANACONDA_CONDA        - The location of the 'conda' program
#
# Outputs :
#   ANACONDA_FOUND        - True if Anaconda found.
#   ANACONDA_ROOT         - The root of Anaconda installation
#   ANACONDA_VERSION      - The version of conda found
#

find_program( ANACONDA_CONDA NAMES conda)

execute_process(
  COMMAND ${ANACONDA_CONDA} --version
  ERROR_VARIABLE _anaconda_conda_version_output
  ERROR_STRIP_TRAILING_WHITESPACE
  )

string(REGEX REPLACE "conda ([0-9]+\\.[0-9]+\\.[0-9]+)" "\\1" _anaconda_version_string "${_anaconda_conda_version_output}")
if (Anaconda_FIND_VERSION AND NOT _anaconda_version_string)
  message(FATAL_ERROR "Unable to figure out anaconda version from ${ANACONDA_CONDA}. Check your ANACONDA_CONDA variable content")
endif()

# TODO : extract list of installed packages and handle that as CMake "components"
execute_process(
  COMMAND ${ANACONDA_CONDA} list
  OUTPUT_VARIABLE _anaconda_conda_list_output
  ERROR_QUIET
  )

string(REGEX REPLACE "\r?\n" ";" _anaconda_conda_list_output_aslist  ${_anaconda_conda_list_output})
set(_anaconda_modules "")
foreach(_line IN LISTS _anaconda_conda_list_output_aslist)
  if(_line)
    set(_module_regex "^([-_a-zA-Z1-9]+).*$")
    string(REGEX MATCH ${_module_regex} _has_match ${_line})
    if (_has_match)
      string(REGEX REPLACE ${_module_regex} "\\1" _anaconda_module ${_line})
      list(APPEND _anaconda_modules ${_anaconda_module})
      set(Anaconda_${_anaconda_module}_FOUND ON)
    endif()
  endif()
endforeach()

foreach(_required_component IN LISTS Anaconda_FIND_COMPONENTS)
  if( NOT Anaconda_${_required_component}_FOUND )
    message(WARNING "Unable to find required anaconda module : ${_required_component}. You can install this module by running : conda install ${_required_component}")
  endif()
endforeach()

# handle the QUIETLY and REQUIRED arguments and set ANACONDA_FOUND to TRUE if
# all listed variables are TRUE
include( FindPackageHandleStandardArgs )
FIND_PACKAGE_HANDLE_STANDARD_ARGS( Anaconda
  REQUIRED_VARS ANACONDA_CONDA
  VERSION_VAR _anaconda_version_string
  HANDLE_COMPONENTS
  )

mark_as_advanced( ANACONDA_CONDA )

if (ANACONDA_FOUND)
  get_filename_component(_anaconda_conda ${ANACONDA_CONDA} REALPATH)
  get_filename_component(_anaconda_conda_dir ${_anaconda_conda} DIRECTORY)
  get_filename_component(_anaconda_root ${_anaconda_conda_dir} DIRECTORY)
  set(ANACONDA_ROOT ${_anaconda_root})
  set(ANACONDA_VERSION ${_anaconda_version_string})
else()
  set(ANACONDA_ROOT "")
  set(ANACONDA_VERSION "")
endif()
