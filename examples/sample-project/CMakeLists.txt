cmake_minimum_required(VERSION 3.9)
project(xlw_cmake_fork)
set(CMAKE_CXX_STANDARD 14)     
set(CMAKE_VERBOSE_MAKEFILE ON)


if(NOT DEFINED ${XLW_INSTALL_PATH})
  set(XLW_INSTALL_PATH "$ENV{USERPROFILE}/xlw-lib")
endif()

# Function for defining Excel Addin targets 
#
function(add_xll_addin )
  # If the following variable is not defined. Assumes that its value is 
  # %USERPROFILE%\xlw-lib. It is expanded to C:\\Users\<MYUSER>\xlw-lib 
  #==================================================================
  set(source_list ${ARGV})
  set(target  ${ARGV0})
  list(REMOVE_AT source_list 0)

  string(REPLACE ";" " " source_list_str "${source_list}")
  # set(source_list ${source_list})
  # separate_arguments(source_list)
  
  message("source_list = ${source_list_str} ")
  add_library(${target} SHARED ${source_list})
  target_include_directories(${target} PRIVATE  ${XLW_INSTALL_PATH}/include ".")
  target_link_libraries(${target} PRIVATE ${XLW_INSTALL_PATH}/lib/xlw.lib)
  set_target_properties(${target} PROPERTIES SUFFIX ".xll") 
endfunction()


function(interfaceGenerator outputFile  inputFile)
  get_filename_component(baseName ${inputFile} NAME_WE)
  set(generated_file ${CMAKE_CURRENT_SOURCE_DIR}/xlw${baseName}.cxx)

  add_custom_command(
    OUTPUT   ${generated_file}
    COMMAND  ${XLW_INSTALL_PATH}/bin/InterfaceGenerator.exe mylib.h 
    DEPENDS  mylib.h
    COMMENT " [INFO] Generating XLW interface file "
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
  ) 
  set(${outputFile} ${generated_file} PARENT_SCOPE)
endfunction()

# Copy target after it is build to directory where is this file CMakeLists.txt.
#
function(copy_after_build target)
  add_custom_command(TARGET ${target} POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy 
    $<TARGET_FILE:${target}>                 # Source    
    ${CMAKE_CURRENT_SOURCE_DIR}          # Destination, file or directory 
    # OR: ${CMAKE_CURRENT_SOURCE_DIR}/   # Directory destination. 
  )
endfunction()

#========= Addin Definition ============#

interfaceGenerator(mylib_interface mylib.h)
add_xll_addin(mylib  mylib.cpp ${mylib_interface})
copy_after_build(mylib)

