cmake_minimum_required(VERSION 3.9)
project(xlw_test)
set(CMAKE_CXX_STANDARD 14)     
set(CMAKE_VERBOSE_MAKEFILE ON)


set(CMAKE_WINDOWS_EXPORT_ALL_SYMBOLS TRUE)
set(UILD_SHARED_LIBS TRUE)


#  Target: ./bin/InterfaceGenerator.exe 
#---------------------------------------------------------------------
file(GLOB SRC_FILES InterfaceGenerator/*.cpp)
add_executable(InterfaceGenerator ${SRC_FILES})
target_include_directories(InterfaceGenerator PRIVATE "./InterfaceGenerator")

# Target: xlw.lib  - 
# See: https://stackoverflow.com/questions/34659795/c
#      https://cmake.org/Bug/view.php?id=7835
#----------------------------------------------
file(GLOB XLW_SRC_FILES src/*.cpp)
add_library(xlw  ${XLW_SRC_FILES} include/xlw/xlw.def)
target_include_directories(xlw PUBLIC ./include)
set_source_files_properties(xlw.def PROPERTIES HEADER_FILE_ONLY TRUE)


#----------------- Build Example --------------------#
# https://blog.kitware.com/create-dlls-on-windows-without-declspec-using-new-cmake-export-all-feature/
add_library(mylib SHARED  xll_test1/mylib.cpp xll_test1/xlwmylib.cpp)
target_include_directories(mylib PRIVATE  xll_test1/)
target_link_libraries(mylib PRIVATE xlw)


add_custom_command(TARGET mylib POST_BUILD
  COMMAND ${CMAKE_COMMAND} -E copy 
  $<TARGET_FILE:mylib>                     # Source    
  ${CMAKE_CURRENT_SOURCE_DIR}/mylib.xll     # Destination, file or directory 
  # OR: ${CMAKE_CURRENT_SOURCE_DIR}/         # Directory destination. 
)

# Install 
#--------------------------------------------------------------------
install(TARGETS InterfaceGenerator xlw mylib  DESTINATION  ${CMAKE_CURRENT_LIST_DIR}/bin)