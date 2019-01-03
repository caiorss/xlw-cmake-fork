:: Brief:   Batch script for automatically building all targets with CMake
:: Author:  Caio Rodrigues    
:: ==============================================================
@echo off

@echo Automate CMake initialization.

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
cmake --build cache --target install 
    
:: "C:\Program Files\CMake\bin\cmake" --build build --config Release -- install VERBOSE=1

@echo Compilation finished
::-----------------------------------------------::
:: Wait user enter any key to exit
pause 
