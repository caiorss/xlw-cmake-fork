:: Brief:   Batch script for automatically build and install all targets 
:: Author:  Caio Rodrigues    
:: ==============================================================
@echo off

@echo Setting up project
@echo --------------------------------------------------
::  Generate specific preferred project for current platform  
cmake -H. -Bninja-mingw -G Ninja

@echo Executing Install Target
@echo --------------------------------------------------
:: Build project and copy executable and dll to this directory
cmake --build ninja-mingw --target install 
    
:: "C:\Program Files\CMake\bin\cmake" --build build --config Release -- install VERBOSE=1

@echo Compilation finished
::-----------------------------------------------::
:: Wait user enter any key to exit
pause 
