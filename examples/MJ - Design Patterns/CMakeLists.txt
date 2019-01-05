cmake_minimum_required(VERSION 3.9)
project(xlwPayoff)
set(CMAKE_CXX_STANDARD 14)     
set(CMAKE_VERBOSE_MAKEFILE ON)

include("$ENV{USERPROFILE}\\xlw-lib\\XLWFunctions.cmake")

#========= Addin Definition ============#

# Generate interface file xlwTest.h
#------------------------------------------------
interfaceGenerator(XLWInterface src/Test.h)
message(" [INFO] interface file = "${XLWInterface})

add_xll_addin( Payoff
               #-- Sources ----#
               src/PayOffConcrete.cpp
               src/PayOff.cpp
               src/PayOffRegistration.cpp
               src/Test.cpp
               ${XLWInterface}
             )

# Copy Excel XLL addin to current directory
copy_after_build(Payoff)

