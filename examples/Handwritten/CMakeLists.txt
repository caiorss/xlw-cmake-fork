cmake_minimum_required(VERSION 3.9)
project(HandWritten)
set(CMAKE_CXX_STANDARD 14)     
set(CMAKE_VERBOSE_MAKEFILE ON)

include("$ENV{USERPROFILE}\\xlw-lib\\XLWFunctions.cmake")

#========= Addin Definition ============#

# Generate interface file xlwTest.h
#------------------------------------------------
# interfaceGenerator(XLWInterface source/cppinterface.h)
# message(" [INFO] interface file = "${XLWInterface})

add_xll_addin(HandWritten
              src/xlwAsynchExample.cpp
              src/xlwCommands.cpp
              src/xlwExample.cpp
              src/xlwMatrixTest.cpp
              src/xlwXlmMacros.cpp
              )

# Copy Excel XLL addin to current directory
copy_after_build(HandWritten)

