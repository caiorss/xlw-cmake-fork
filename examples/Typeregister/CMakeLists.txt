cmake_minimum_required(VERSION 3.9)
project(xlwTypeRegDemo)
set(CMAKE_CXX_STANDARD 14)     
set(CMAKE_VERBOSE_MAKEFILE ON)

include("$ENV{USERPROFILE}\\xlw-lib\\XLWFunctions.cmake")

#========= Addin Definition ============#

# Generate interface file xlwTest.h
#------------------------------------------------
interfaceGenerator(XLWInterface src/Test.h)
message(" [INFO] interface file = "${XLWInterface})

add_xll_addin( TypeRegDemo
               src/Test.cpp
               src/type_conversions.cpp
               ${XLWInterface}
             )

# target_include_directories(ObjectCacheDemo PRIVATE "./src")
           
# Copy Excel XLL addin to current directory
copy_after_build(TypeRegDemo)

