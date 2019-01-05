:: Build project using Visual Studio tools
:: (MSBuild and Visual Studio Solutions)
:: Note: Assumes that CMake is in $PATH variable.
::====================================================================    
@echo off
@echo Building project 

:: Alias to executable
set CMAKEBIN="C:\Program Files\CMake\bin\cmake"

@echo Configuring project
@echo --------------------------------------------------
::  Generate specific preferred project for current platform  
cmake -H. -Bmsvc -G "Visual Studio 15 2017" 

@echo Build all targets
@echo --------------------------------------------------
:: Build project and copy executable and dll to this directory
cmake --build msvc --target 
    
@echo Compilation finished
::-----------------------------------------------::
:: Wait user enter any key to exit
pause 
