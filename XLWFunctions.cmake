#=========================================================================
# Functions for making the development of Excel native Addins with XLW
# framework and CMake easier. This file exports common functionalities
# and functions that can be reused by all XLW-cmake projects.
# ------------------------------------------------------------------------
# Author: Caio Rodrigues.
#
# Exported functions:
#  + add_xll_addin( <ADDIN-TARGET-NAME>  <SOURCE> ... )
#     Create an target to build Excel addin (Excel extension) using XLW library.
#
#  + InterfaceGeneator(<FILE-NAME-VARIABLE> <HEADER-FILE> )
#     Generate XLW interface code (*.cxx file) out of a header file. 
#   
#  + copy_after_build(<TARGET>)
#     Copy XLL extension to project directory. 
#
#=======================================================================#


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
  # baseName:  File name without extension and path.
  get_filename_component(baseName ${inputFile} NAME_WE)
  # absDir: Absolute directory path 
  get_filename_component(absFilePath   ${inputFile}   ABSOLUTE DIRECTORY)
  get_filename_component(absDir        ${absFilePath} DIRECTORY)
  set(generated_file ${absDir}/xlw${baseName}.cxx)

 #==> Enable the following commands for debugging. 
 # message(" [INFO XLWFunctions.cmake] => File path = ${absFilePath}")
 # message(" [INFO XLWFunctions.cmake] => Generating file = ${generated_file}")
  
  add_custom_command(
    OUTPUT   ${generated_file}
    COMMAND  ${XLW_INSTALL_PATH}/bin/InterfaceGenerator.exe ${absFilePath}
    DEPENDS  ${inputFile}
    COMMENT " [INFO] Generating XLW interface file at absDir = ${absDir} "
    WORKING_DIRECTORY ${absDir}
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
