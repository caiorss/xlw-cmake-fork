cmake_minimum_required(VERSION 3.9)
project(xlw_InterfaceGenerator)
set(CMAKE_CXX_STANDARD 14)     
set(CMAKE_VERBOSE_MAKEFILE ON)


# set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS TRUE)
# set(UILD_SHARED_LIBS TRUE)

#  Target: ./bin/InterfaceGenerator.exe 
#---------------------------------------------------------------------
file(GLOB SRC_FILES *.cpp)
add_executable(InterfaceGenerator ${SRC_FILES})
#target_include_directories(InterfaceGenerator PRIVATE "xlw/InterfaceGenerator")


install(TARGETS InterfaceGenerator
        DESTINATION ${XLW_INSTALL_PATH}/bin)