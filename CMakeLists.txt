cmake_minimum_required(VERSION 3.9)
project(xlw_cmake_fork)
set(CMAKE_CXX_STANDARD 14)     
set(CMAKE_VERBOSE_MAKEFILE ON)


# set (CMAKE_INSTALL_PREFIX "C:/Users/archbox/libraries/excel-xlw")

# If the following variable is not defined. The static library xlw.lib is 
# installed at %USERPROFILE%\xlw-lib which will expand to 
# C:\\Users\<MYUSER>\xlw-lib 
#==================================================================
if(NOT DEFINED ${XLW_INSTALL_PATH})
  set(XLW_INSTALL_PATH "$ENV{USERPROFILE}/xlw-lib")
endif()

message(" [INFO] CMAKE_INSTALL_PREFIX = ${CMAKE_INSTALL_PREFIX} ")
message(" [INFO] Install library to path => XLW_INSTALL_PATH = ${XLW_INSTALL_PATH} ")


# Target: xlw.lib => static library 
add_subdirectory(./xlw)

#  Target: ./bin/InterfaceGenerator.exe 
#---------------------------------------------------------------------
add_subdirectory(./InterfaceGenerator/)


#---------------------------------------------------#
#      Handwritten XLL Addins - Extensions          #
#---------------------------------------------------#

# Target:  xlwExample 
#----------------------------------------
add_library(xlwExample SHARED examples/Handwritten/common_source/xlwExample.cpp )
target_link_libraries(xlwExample PRIVATE xlw)
set_target_properties(xlwExample PROPERTIES SUFFIX ".xll")


# Target: xlwCommands.xll 
#---------------------
add_library(xlwCommands SHARED examples/Handwritten/common_source/xlwCommands.cpp )
target_link_libraries(xlwCommands PRIVATE xlw)

set_target_properties(xlwCommands PROPERTIES SUFFIX ".xll")


# Install at ./bin in project ROOT directory
#--------------------------------------------------------------------
# install(TARGETS mylib xlwExample xlwCommands DESTINATION  bin)
# include(CMakePackageCOnfigHelpers)
# configure_package_config_file(Config.cmake.in  )
# export(PACKAGE xlw)
