:: Build project using Nija building systems which is
:: much faster than MSVC (MSBuild and Visual Studio Solutions)
::====================================================================
@echo off
@echo Building project

:: Alias to executable
set CMAKEBIN="C:\Program Files\CMake\bin\cmake"

@echo Configure
@echo --------------------------------------------------


:: MSVC 2017
:: call "C:\Program Files (x86)\Microsoft Visual Studio 14.0/VC/vcvarsall.bat"

cmake -H. -Bninja -G Ninja -DCMAKE_IGNORE_PATH=C:/tools/mingw64/bin/ ^
    -DCMAKE_C_COMPILER=x86_64-w64-mingw32-gcc ^
    -DCMAKE_CXX_COMPILER=x86_64-w64-mingw32-g++
    
:: Ignore paths to force compilation with MSVC cl.exe (VC++)
rem cmake -H. -Bninja -G Ninja ^
rem     -DCMAKE_BUILD_TYPE:STRING=Debug ^
rem     -DCMAKE_IGNORE_PATH=C:/tools/mingw64/bin/ ^
rem     -DCMAKE_CXX_COMPILER=cl.exe ^
rem     -DCMAKE_C_COMPILER=cl.exe ^
rem     -DCMAKE_LINKER=link.exe ^
rem     -DCMAKE_CXX_FLAGS:STRING="/DWIN3xd2 /D_WINDOWS /W3 /GR /EHsc" ^
rem     -DCMAKE_CXX_FLAGS_DEBUG:STRING="/MDd /Zi /Ob0 /Od /RTC1" ^
rem     -DCMAKE_EXE_LINKER_FLAGS:STRING=/machine:X86 ^
rem     -DCMAKE_C_FLAGS:STRING="/DWIN32 /D_WINDOWS /W3" ^
rem     -DCMAKE_C_FLAGS_DEBUG:STRING="/MDd /Zi /Ob0 /Od /RTC1" ^
rem     -DCMAKE_C_STANDARD_LIBRARIES:STRING="kernel32.lib user32.lib gdi32.lib winspool.lib shell32.lib ole32.lib oleaut32.lib uuid.lib comdlg32.lib advapi32.lib" ^
rem     -DCMAKE_EXPORT_COMPILE_COMMANDS:BOOL=OFF ^
rem     -DCMAKE_MAKE_PROGRAM=ninja.exe

    @echo Build
@echo --------------------------------------------------
:: Build project and copy executable and dll to this directory
cmake --build ninja  --target

@echo Compilation finished
::-----------------------------------------------::
:: Wait user enter any key to exit
pause
