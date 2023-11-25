project(lpng LANGUAGES C)

file(GLOB lpng_sources
  ./*.c
)

file(GLOB lpng_includes
  ./*.h
)

add_library(lpng STATIC ${lpng_sources})
target_include_directories(lpng PUBLIC ./)