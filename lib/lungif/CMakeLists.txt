project(lungif LANGUAGES C)

file(GLOB lungif_sources
  ./*.c
)

file(GLOB lungif_includes
  ./*.h
)

add_library(lungif STATIC ${lungif_sources})
target_include_directories(lungif PUBLIC ./)