project(ljpeg LANGUAGES C)

file(GLOB ljpeg_sources
  ./*.c
)

list(FILTER ljpeg_sources EXCLUDE REGEX "jmemdos.c|jmemmac.c|jmemname.c|jpegtran.c")

file(GLOB_RECURSE ljpeg_includes
  ./*.h
)

add_library(ljpeg STATIC ${ljpeg_sources})
target_include_directories(ljpeg PUBLIC ./ ./extras)