cmake_minimum_required(VERSION 3.9)
project(xlw_smaple_addin)
set(CMAKE_CXX_STANDARD 14)     
set(CMAKE_VERBOSE_MAKEFILE ON)


if(NOT DEFINED ${XLW_INSTALL_PATH})
  set(XLW_INSTALL_PATH "$ENV{USERPROFILE}/xlw-lib")
endif()
include(${XLW_INSTALL_PATH}/XLWFunctions.cmake)

#========= Addin Definition ============#

interfaceGenerator(mylib_interface mylib.h)
add_xll_addin(mylib  mylib.cpp ${mylib_interface})
copy_after_build(mylib)

