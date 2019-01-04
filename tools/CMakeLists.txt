cmake_minimum_required(VERSION 3.9)
project(xlw_InterfaceGenerator)
set(CMAKE_CXX_STANDARD 14)     
set(CMAKE_VERBOSE_MAKEFILE ON)

if(NOT DEFINED ${XLW_INSTALL_PATH})
  set(XLW_INSTALL_PATH "$ENV{USERPROFILE}/xlw-lib")
endif()

# set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS TRUE)
# set(UILD_SHARED_LIBS TRUE)

#  Target: ./bin/InterfaceGenerator.exe 
#---------------------------------------------------------------------
file(GLOB SRC_FILES InterfaceGenerator/*.cpp)
add_executable(InterfaceGenerator ${SRC_FILES})
#target_include_directories(InterfaceGenerator PRIVATE "xlw/InterfaceGenerator")

add_executable(XlwDocGen  XlwDocGen/XlwDocGen.cpp)

# Install executables to %USERPROFILE%\xlw-lib\bin 
# or C:\Users\<<CURRENT-URSER>>\xlw-lib\xlw-lib\bin
install(TARGETS InterfaceGenerator XlwDocGen
        DESTINATION ${XLW_INSTALL_PATH}/bin)