# Minimal CMAke project file for building XLW addins for 
# Excel XLL API (Excel native interface C-API)
#
#====================================================
cmake_minimum_required(VERSION 3.9)
project(FirstProject)
set(CMAKE_CXX_STANDARD 14)     
set(CMAKE_VERBOSE_MAKEFILE ON)

include("$ENV{USERPROFILE}\\xlw-lib\\XLWFunctions.cmake")

#========= Addin Definition ============#

# Generate interface file xlwTest.h
interfaceGenerator(XLWInterface source/cppinterface.h)
message(" [INFO] interface file = "${XLWInterface})

# Generates Excel XLL Addin file: ExcelAddin.xll
# (Note: It is a DLL renamed to .xll)
add_xll_addin(ExcelAddin source/source.cpp  ${XLWInterface})

# Copy Excel XLL addin to current directory
copy_after_build(ExcelAddin)

