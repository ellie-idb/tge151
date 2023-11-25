file(GLOB_RECURSE engine_sources 
  audio/*.cc
  collision/*.cc
  console/*.cc
  core/*.cc
  dgl/*.cc
  editor/*.cc
  gui/*.cc
  i18n/*.cc
  interior/*.cc
  math/*.cc
  platform/*.cc
  sim/*.cc
  game/*.cc
  util/*.cc
  sceneGraph/*.cc
  terrain/*.cc
  ts/*.cc
  lightingSystem/*.cc
)

if (WIN32)
  file(GLOB_RECURSE platform_sources
    platformWin32/*.cc
  )
elseif(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
  file(GLOB_RECURSE platform_sources
    platformMacCarb/*.cc
  )
else()
  message(FATAL_ERROR "Unsupported platform")
endif()


add_executable(torqueDemo ${engine_sources} ${platform_sources})

target_compile_definitions(torqueDemo PRIVATE
  TORQUE_DISABLE_MEMORY_MANAGER
)
target_link_libraries(torqueDemo PRIVATE vorbis OpenAL lungif ljpeg lpng)
target_include_directories(torqueDemo PRIVATE
  ./
  ../lib/openal-soft/al
)

