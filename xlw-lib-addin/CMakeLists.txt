cmake_minimum_required(VERSION 3.9)
project(xlw_cmake_library)
set(CMAKE_CXX_STANDARD 14)     
set(CMAKE_VERBOSE_MAKEFILE ON)

# If the following variable is not defined. The static library xlw.lib is 
# installed at %USERPROFILE%\xlw-lib which will expand to 
# C:\\Users\<MYUSER>\xlw-lib 
#==================================================================
if(NOT DEFINED ${XLW_INSTALL_PATH})
  set(XLW_INSTALL_PATH "$ENV{USERPROFILE}/xlw-lib")
endif()

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

# Check whether compilation is set for MSVC ("Visual" C++) 32 bits target (x86)
if(MSVC AND NOT CMAKE_CL_64)
  # The generated file will be  xlw-msvc-x86.lib 
  set_target_properties(xlw PROPERTIES OUTPUT_NAME "xlw-msvc-x86")
endif()

# Check whether compilation is set for MSVC (Visual C++) 32 bits target (x64)
if(MSVC AND CMAKE_CL_64)
  # The generated file will be  xlw-msvc-x64.lib 
  set_target_properties(xlw PROPERTIES OUTPUT_NAME "xlw-msvc-x64")
endif()

# Check whether current compiler is MINGW set for 32 bits target (x86)
if(MINGW AND NOT CMAKE_SIZEOF_VOID_P EQUAL 8)
  set_target_properties(xlw PROPERTIES OUTPUT_NAME "xlw-mingw-x86")
endif()

# Check whether current compiler is MINGW set for 32 bits target (x64)
if(MINGW AND CMAKE_SIZEOF_VOID_P EQUAL 8)
  set_target_properties(xlw PROPERTIES OUTPUT_NAME "xlw-mingw-x64")
endif()

get_target_property(XLW_OUTPUT_FILE xlw  OUTPUT_NAME)
message(" [INFO] {XWL-LIB-ADDIN} XLW target output file = \"${XLW_OUTPUT_FILE}.lib\" ")


#install(EXPORT)

install(TARGETS xlw DESTINATION ${XLW_INSTALL_PATH}/lib)
install(DIRECTORY  ${XLW_INCLUDE_PATH}  DESTINATION ${XLW_INSTALL_PATH} FILES_MATCHING PATTERN "*")
