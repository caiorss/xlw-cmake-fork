cmake_minimum_required(VERSION 3.9)
project(xlw_cmake_library)
set(CMAKE_CXX_STANDARD 14)     
set(CMAKE_VERBOSE_MAKEFILE ON)

set(XLW_SOURCE_PATH  src)
set(XLW_INCLUDE_PATH include)

# Target: xlw.lib  - 
# See: https://stackoverflow.com/questions/34659795/c
#      https://cmake.org/Bug/view.php?id=7835
#----------------------------------------------
file(GLOB XLW_CPP_FILES ${XLW_SOURCE_PATH}/*.cpp)
add_library(xlw  ${XLW_CPP_FILES} ${XLW_INCLUDE_PATH}/xlw/xlw.def)
target_include_directories(xlw PUBLIC ${XLW_INCLUDE_PATH})
set_source_files_properties(xlw.def PROPERTIES HEADER_FILE_ONLY TRUE)


#install(EXPORT)

install(TARGETS xlw DESTINATION ${XLW_INSTALL_PATH}/lib)
install(DIRECTORY  ${XLW_INCLUDE_PATH}  DESTINATION ${XLW_INSTALL_PATH} FILES_MATCHING PATTERN "*")
