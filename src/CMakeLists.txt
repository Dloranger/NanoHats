##############################################################################
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
##############################################################################

##############################################################################
# Project setup
##############################################################################
cmake_minimum_required(VERSION 2.8)
project(nanonatoled C)
#enable_testing()

# Where to put executable files
set(RUNTIME_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/sbin)

# Add project local CMake module directory
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake/Modules/")

# Set up include directories
include_directories(
  ${PROJECT_INCLUDE_DIR}
  ${CMAKE_BINARY_DIR}
)

# Warnings should be enabled for GCC. Also turning off the NDEBUG flag
# since that remove asserts.
  set(CMAKE_C_FLAGS
    "${CMAKE_C_FLAGS} -Wall -Wstrict-prototypes -Wpointer-arith")
  set(CMAKE_C_FLAGS_RELEASE "-O3")
  set(CMAKE_C_FLAGS_RELWITHDEBINFO "-O2 -g")

 # Set the default build type to Release
if(NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE "Release" CACHE STRING
      "Choose the type of build, options are: None(CMAKE_CXX_FLAGS or CMAKE_C_FLAGS used) Debug Release RelWithDebInfo MinSizeRel."
      FORCE)
endif(NOT CMAKE_BUILD_TYPE)
  
##############################################################################
# Install targets properties setup
##############################################################################

# Set up standard GNU installation directories
include(GNUInstallDirs)

# The config directory (normally /etc)
if(NOT DEFINED SYSCONF_INSTALL_DIR)
  #set(SYSCONF_INSTALL_DIR ${CMAKE_INSTALL_PREFIX}/etc)
  set(SYSCONF_INSTALL_DIR ${CMAKE_INSTALL_FULL_SYSCONFDIR})
endif(NOT DEFINED SYSCONF_INSTALL_DIR)

# Architecture independent files directory (normally /usr/share)
if(NOT DEFINED SHARE_INSTALL_PREFIX)
  #set(SHARE_INSTALL_PREFIX ${CMAKE_INSTALL_PREFIX}/share)
  set(SHARE_INSTALL_PREFIX ${CMAKE_INSTALL_FULL_DATADIR})
endif(NOT DEFINED SHARE_INSTALL_PREFIX)

# Local state directory (normally /var)
if(NOT DEFINED LOCAL_STATE_DIR)
  #set(LOCAL_STATE_DIR ${CMAKE_INSTALL_PREFIX}/var)
  set(LOCAL_STATE_DIR ${CMAKE_INSTALL_FULL_LOCALSTATEDIR})
endif(NOT DEFINED LOCAL_STATE_DIR)

# Where to install executables
if(NOT DEFINED BIN_INSTALL_DIR)
  #set(BIN_INSTALL_DIR ${CMAKE_INSTALL_PREFIX}/bin)
  set(BIN_INSTALL_DIR ${CMAKE_INSTALL_FULL_BINDIR})
endif(NOT DEFINED BIN_INSTALL_DIR)

# Where to install system executables
if(NOT DEFINED SBIN_INSTALL_DIR)
  #set(BIN_INSTALL_DIR ${CMAKE_INSTALL_PREFIX}/sbin)
  set(SBIN_INSTALL_DIR ${CMAKE_INSTALL_FULL_SBINDIR})
endif(NOT DEFINED SBIN_INSTALL_DIR)

# Where to install startup scripts
if(NOT DEFINED INIT_D_INSTALL_DIR)
  set(INIT_D_INSTALL_DIR ${SYSCONF_INSTALL_DIR}/init.d)
endif(NOT DEFINED INIT_D_INSTALL_DIR)

# Where to install BBLink architecture independent files
if(NOT DEFINED BB_SHARE_INSTALL_DIR)
  set(BB_SHARE_INSTALL_DIR ${SHARE_INSTALL_PREFIX}/bakebit)
endif(NOT DEFINED BB_SHARE_INSTALL_DIR)

##############################################################################
# Functions
##############################################################################

# Create an include file under the global include directory
function(expinc filename)
  configure_file(${CMAKE_CURRENT_SOURCE_DIR}/${filename}
    ${PROJECT_INCLUDE_DIR}/${filename}
    COPYONLY
    )
endfunction(expinc)

# Add a target for building a version/xyz.h file
#
#   add_version_target(name [depends_var])
#
# The name of the version variable should be VER_name and the versions file
# will be named versions/name.h.
# If depends_var is given it will be set to a list of dependencies that the
# target using the versions file should add to its dependency list.
function(add_version_target name)
  set(depends_var ${ARGV1})
  if(DEFINED depends_var)
    set(${depends_var} ${${depends_var}}
      "${PROJECT_INCLUDE_DIR}/version/${name}.h"
      PARENT_SCOPE
      )
  endif(DEFINED depends_var)

  if(VER_${name})
    set(VERSION ${VER_${name}})
  else(VER_${name})
    set(VERSION "?.?.?")
  endif(VER_${name})

  add_custom_command(
    OUTPUT ${PROJECT_INCLUDE_DIR}/version/${name}.h
    WORKING_DIRECTORY ${PROJECT_INCLUDE_DIR}
    COMMAND ${CMAKE_COMMAND} -DVER_NAME=${name} -DVER_VALUE=${VERSION} 
                     -P ${CMAKE_SOURCE_DIR}/cmake/create_version_include.cmake
    DEPENDS ${CMAKE_SOURCE_DIR}/versions
            ${CMAKE_SOURCE_DIR}/cmake/create_version_include.cmake
  )
endfunction(add_version_target)

# Read a versions file and set up CMake variables for each entry
function(read_versions_file filename)
  message(STATUS "Reading versions file...")
  file(STRINGS ${filename} versions REGEX .*=.*)
  foreach(version ${versions})
    string(REGEX REPLACE \(.*\)=\(.*\) "VER_\\1;\\2" version ${version})
    set(${version} PARENT_SCOPE)
    if(version MATCHES ^VER_LIB)
      list(GET version 0 varname)
      list(GET version 1 varvalue)
      string(REGEX MATCH [0-9]+\\.[0-9]+ ${varname}_SOVERSION ${varvalue})
      set(${varname}_SOVERSION ${${varname}_SOVERSION} PARENT_SCOPE)
    endif(version MATCHES ^VER_LIB)
  endforeach(version)
endfunction(read_versions_file)

# Create a post install target to change the owner of an installed file.
# If DO_INSTALL_CHOWN is set to YES, the owner will be changed during
# installation.
# If DO_INSTALL_CHOWN is unset, the DESTDIR environment variable will be
# examined. If it is set, no chown operations will be performed since we are
# probably not running as a user with administrative rights. If DESTDIR is
# unset, chown operations are performed.
function(install_chown filename owner)
  if(owner)
    set(chown_commands "
      set(CHOWN_TOOL ${CHOWN_TOOL})
      if(NOT CHOWN_TOOL)
        MESSAGE(FATAL_ERROR \"Unable to find the 'chown' utility\")
      endif(NOT CHOWN_TOOL)
      set(full_filename \"\$ENV{DESTDIR}${filename}\")
      message(STATUS \"Setting owner of \${full_filename} to ${owner}...\")
      execute_process(
        COMMAND ${CHOWN_TOOL} ${owner} \"\${full_filename}\"
        RESULT_VARIABLE cmd_result
        )
      if(NOT \${cmd_result} EQUAL 0)
        MESSAGE(FATAL_ERROR
          \"Error while changing owner of file \${full_filename}\"
          )
      endif(NOT \${cmd_result} EQUAL 0)
      ")
    if(DEFINED DO_INSTALL_CHOWN)
      if(DO_INSTALL_CHOWN)
        install(CODE "${chown_commands}")
      endif(DO_INSTALL_CHOWN)
    else(DEFINED DO_INSTALL_CHOWN)
      install(CODE "
        if(\"\$ENV{DESTDIR}\" STREQUAL \"\")
          ${chown_commands}
        endif(\"\$ENV{DESTDIR}\" STREQUAL \"\")
        ")
    endif(DEFINED DO_INSTALL_CHOWN)
  endif(owner)
endfunction(install_chown)

# Create the given directory during installation
#   install_mkdir(directory [owner])
function(install_mkdir dir)
  set(owner ${ARGV1})
  get_filename_component(parent ${dir} PATH)
  file(MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}${dir})
  install(DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}${dir} DESTINATION ${parent})
  install_chown(${dir} "${owner}")
endfunction(install_mkdir)

# Before installing the file, check if it exists. If it does, don't
# overwrite it.
#   install_if_not_exists(source_file destination_directory)
function(install_if_not_exists src dest)
  if(NOT IS_ABSOLUTE "${src}")
    set(src "${CMAKE_CURRENT_SOURCE_DIR}")
  endif()
  get_filename_component(src_name "${src}" NAME)
  if (NOT IS_ABSOLUTE "${dest}")
    set(dest "${CMAKE_INSTALL_PREFIX}/${dest}")
  endif()
  install(CODE "
    if(NOT EXISTS \"\$ENV{DESTDIR}${dest}/${src_name}\")
      #file(INSTALL \"${src}\" DESTINATION \"${dest}\")
      message(STATUS \"Installing: \$ENV{DESTDIR}${dest}/${src_name}\")
      execute_process(COMMAND \${CMAKE_COMMAND} -E copy \"${src}\"
                      \"\$ENV{DESTDIR}${dest}/${src_name}\"
                      RESULT_VARIABLE copy_result
                      ERROR_VARIABLE error_output)
      if(copy_result)
        message(FATAL_ERROR \${error_output})
      endif()
    else()
      message(STATUS \"Skipping  : \$ENV{DESTDIR}${dest}/${src_name}\")
    endif()
  ")
endfunction(install_if_not_exists)

##############################################################################
# Main execution starts here
##############################################################################

# Load the versions file and define version variables
read_versions_file(${PROJECT_SOURCE_DIR}/versions)

# Find the chown utility
include(FindCHOWN)

# Add directories toc  build
add_subdirectory(software)

option(HATHUB "Set to ON to incude HatHub-C bin files" OFF)
message(STATUS "With HATHUB = ${WITH_HATHUB}")
if(WITH_HATHUB)
  add_subdirectory(HatHub)
endif(WITH_HATHUB)

option(HATMOTOR "Set to ON to incude HatMotor-Python files" OFF)
message(STATUS "With HATMOTOR = ${WITH_HATMOTOR}")
if(WITH_HATMOTOR)
  add_subdirectory(HatMotor)
endif(WITH_HATMMOTOR)

option(HATOLED "Set to ON to incude HatOled-Python files" OFF)
message(STATUS "With HATOLED = ${WITH_HATOLED}")
if(WITH_HATMOTOR)
  add_subdirectory(HatOled)
endif(WITH_HATOLED)

# Experimental CPack package building
set(CPACK_SET_DESTDIR "ON")
set(CPACK_PACKAGE_DESCRIPTION_SUMMARY
  "Advanced voice services system for ham radio use")
execute_process(
  COMMAND git describe --tags
  COMMAND tr - .
  COMMAND tr -d '\n'
  OUTPUT_VARIABLE CPACK_PACKAGE_VERSION)
message(STATUS "Package Version = ${CPACK_PACKAGE_VERSION}")
#set(CPACK_PACKAGE_VERSION "0.1.3")
set(CPACK_PACKAGE_DESCRIPTION
  "Nanopi BakeBit Hat Control software and systemd service files")
#set(CPACK_GENERATOR "DEB")
include(CPack)
