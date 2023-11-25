cmake_minimum_required(VERSION 3.13.0)
set(OPENAL_NO_FRAMEWORK TRUE)
project(torqueDemo LANGUAGES C CXX ASM)

find_package(OpenAL REQUIRED)

add_subdirectory(lib)
add_subdirectory(engine)