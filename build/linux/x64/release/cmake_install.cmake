# Install script for directory: /home/geanfrancobiagi/Documentos/Proyectos/CrazyDisplay/crazydisplay_flutterapp/linux

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/geanfrancobiagi/Documentos/Proyectos/CrazyDisplay/crazydisplay_flutterapp/build/linux/x64/release/bundle")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xRuntimex" OR NOT CMAKE_INSTALL_COMPONENT)
  
  file(REMOVE_RECURSE "/home/geanfrancobiagi/Documentos/Proyectos/CrazyDisplay/crazydisplay_flutterapp/build/linux/x64/release/bundle/")
  
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xRuntimex" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}/home/geanfrancobiagi/Documentos/Proyectos/CrazyDisplay/crazydisplay_flutterapp/build/linux/x64/release/bundle/crazydisplay_flutterapp" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/geanfrancobiagi/Documentos/Proyectos/CrazyDisplay/crazydisplay_flutterapp/build/linux/x64/release/bundle/crazydisplay_flutterapp")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}/home/geanfrancobiagi/Documentos/Proyectos/CrazyDisplay/crazydisplay_flutterapp/build/linux/x64/release/bundle/crazydisplay_flutterapp"
         RPATH "$ORIGIN/lib")
  endif()
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/geanfrancobiagi/Documentos/Proyectos/CrazyDisplay/crazydisplay_flutterapp/build/linux/x64/release/bundle/crazydisplay_flutterapp")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/geanfrancobiagi/Documentos/Proyectos/CrazyDisplay/crazydisplay_flutterapp/build/linux/x64/release/bundle" TYPE EXECUTABLE FILES "/home/geanfrancobiagi/Documentos/Proyectos/CrazyDisplay/crazydisplay_flutterapp/build/linux/x64/release/intermediates_do_not_run/crazydisplay_flutterapp")
  if(EXISTS "$ENV{DESTDIR}/home/geanfrancobiagi/Documentos/Proyectos/CrazyDisplay/crazydisplay_flutterapp/build/linux/x64/release/bundle/crazydisplay_flutterapp" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}/home/geanfrancobiagi/Documentos/Proyectos/CrazyDisplay/crazydisplay_flutterapp/build/linux/x64/release/bundle/crazydisplay_flutterapp")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}/home/geanfrancobiagi/Documentos/Proyectos/CrazyDisplay/crazydisplay_flutterapp/build/linux/x64/release/bundle/crazydisplay_flutterapp"
         OLD_RPATH "/home/geanfrancobiagi/Documentos/Proyectos/CrazyDisplay/crazydisplay_flutterapp/build/linux/x64/release/plugins/file_selector_linux:/home/geanfrancobiagi/Documentos/Proyectos/CrazyDisplay/crazydisplay_flutterapp/linux/flutter/ephemeral:"
         NEW_RPATH "$ORIGIN/lib")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/snap/flutter/current/usr/bin/strip" "$ENV{DESTDIR}/home/geanfrancobiagi/Documentos/Proyectos/CrazyDisplay/crazydisplay_flutterapp/build/linux/x64/release/bundle/crazydisplay_flutterapp")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xRuntimex" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/geanfrancobiagi/Documentos/Proyectos/CrazyDisplay/crazydisplay_flutterapp/build/linux/x64/release/bundle/data/icudtl.dat")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/geanfrancobiagi/Documentos/Proyectos/CrazyDisplay/crazydisplay_flutterapp/build/linux/x64/release/bundle/data" TYPE FILE FILES "/home/geanfrancobiagi/Documentos/Proyectos/CrazyDisplay/crazydisplay_flutterapp/linux/flutter/ephemeral/icudtl.dat")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xRuntimex" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/geanfrancobiagi/Documentos/Proyectos/CrazyDisplay/crazydisplay_flutterapp/build/linux/x64/release/bundle/lib/libflutter_linux_gtk.so")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/geanfrancobiagi/Documentos/Proyectos/CrazyDisplay/crazydisplay_flutterapp/build/linux/x64/release/bundle/lib" TYPE FILE FILES "/home/geanfrancobiagi/Documentos/Proyectos/CrazyDisplay/crazydisplay_flutterapp/linux/flutter/ephemeral/libflutter_linux_gtk.so")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xRuntimex" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/geanfrancobiagi/Documentos/Proyectos/CrazyDisplay/crazydisplay_flutterapp/build/linux/x64/release/bundle/lib/libfile_selector_linux_plugin.so")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/geanfrancobiagi/Documentos/Proyectos/CrazyDisplay/crazydisplay_flutterapp/build/linux/x64/release/bundle/lib" TYPE FILE FILES "/home/geanfrancobiagi/Documentos/Proyectos/CrazyDisplay/crazydisplay_flutterapp/build/linux/x64/release/plugins/file_selector_linux/libfile_selector_linux_plugin.so")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xRuntimex" OR NOT CMAKE_INSTALL_COMPONENT)
  
  file(REMOVE_RECURSE "/home/geanfrancobiagi/Documentos/Proyectos/CrazyDisplay/crazydisplay_flutterapp/build/linux/x64/release/bundle/data/flutter_assets")
  
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xRuntimex" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/geanfrancobiagi/Documentos/Proyectos/CrazyDisplay/crazydisplay_flutterapp/build/linux/x64/release/bundle/data/flutter_assets")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/geanfrancobiagi/Documentos/Proyectos/CrazyDisplay/crazydisplay_flutterapp/build/linux/x64/release/bundle/data" TYPE DIRECTORY FILES "/home/geanfrancobiagi/Documentos/Proyectos/CrazyDisplay/crazydisplay_flutterapp/build//flutter_assets")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xRuntimex" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/home/geanfrancobiagi/Documentos/Proyectos/CrazyDisplay/crazydisplay_flutterapp/build/linux/x64/release/bundle/lib/libapp.so")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/home/geanfrancobiagi/Documentos/Proyectos/CrazyDisplay/crazydisplay_flutterapp/build/linux/x64/release/bundle/lib" TYPE FILE FILES "/home/geanfrancobiagi/Documentos/Proyectos/CrazyDisplay/crazydisplay_flutterapp/build/lib/libapp.so")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/geanfrancobiagi/Documentos/Proyectos/CrazyDisplay/crazydisplay_flutterapp/build/linux/x64/release/flutter/cmake_install.cmake")
  include("/home/geanfrancobiagi/Documentos/Proyectos/CrazyDisplay/crazydisplay_flutterapp/build/linux/x64/release/plugins/file_selector_linux/cmake_install.cmake")

endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/home/geanfrancobiagi/Documentos/Proyectos/CrazyDisplay/crazydisplay_flutterapp/build/linux/x64/release/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
