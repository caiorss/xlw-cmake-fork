:: Note: Assumes that CMake is in $PATH variable.
@echo off
@echo Building project 

:: Alias to executable
set CMAKEBIN="C:\Program Files\CMake\bin\cmake"

@echo Setting up project
@echo --------------------------------------------------
::  Generate specific preferred project for current platform  
cmake -H. -Bcache -G "Visual Studio 15 2017" 

@echo Executing Install Target
@echo --------------------------------------------------
:: Build project and copy executable and dll to this directory
cmake --build cache --target
    
@echo Compilation finished
::-----------------------------------------------::
:: Wait user enter any key to exit
pause 
