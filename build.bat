@echo off
pushd %~dp0

call "%VS140COMNTOOLS%..\..\VC\vcvarsall.bat" amd64

echo #### libprotobuf build started

mkdir build\native\lib\v140\Win32
mkdir build\native\lib\v140\Win32\Debug
mkdir build\native\lib\v140\Win32\Release

cd protobuf\cmake
cmake -G "Visual Studio 14 2015" -Dprotobuf_BUILD_TESTS=OFF -Dprotobuf_WITH_ZLIB=ON
devenv.com protobuf.sln /build "Debug|Win32" /project ALL_BUILD
if not %ERRORLEVEL% == 0 goto Finish
robocopy /mir .\Debug ..\..\install\lib\Win32\Debug

devenv.com protobuf.sln /build "Release|Win32" /project ALL_BUILD
if not %ERRORLEVEL% == 0 goto Finish
robocopy /mir .\Release ..\..\..\install\lib\Win32\Release

echo #### libprotobuf build done!

:Finish
popd
