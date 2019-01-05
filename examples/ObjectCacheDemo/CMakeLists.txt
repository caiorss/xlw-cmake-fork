cmake_minimum_required(VERSION 3.9)
project(xlwObjectCacheDemo)
set(CMAKE_CXX_STANDARD 14)     
set(CMAKE_VERBOSE_MAKEFILE ON)

include("$ENV{USERPROFILE}\\xlw-lib\\XLWFunctions.cmake")

#========= Addin Definition ============#

# Generate interface file xlwTest.h
#------------------------------------------------
interfaceGenerator(XLWInterface src/cppinterface.h)
message(" [INFO] interface file = "${XLWInterface})

add_xll_addin( ObjectCacheDemo
               src/DiscountCurve.cpp
               src/source.cpp
               ${XLWInterface}
             )

target_include_directories(ObjectCacheDemo PRIVATE "./src")
           
# Copy Excel XLL addin to current directory
copy_after_build(ObjectCacheDemo)

