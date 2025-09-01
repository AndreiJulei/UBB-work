# Additional clean files
cmake_minimum_required(VERSION 3.16)

if("${CONFIG}" STREQUAL "" OR "${CONFIG}" STREQUAL "Debug")
  file(REMOVE_RECURSE
  "CMakeFiles/QtOOPApp_autogen.dir/AutogenUsed.txt"
  "CMakeFiles/QtOOPApp_autogen.dir/ParseCache.txt"
  "QtOOPApp_autogen"
  )
endif()
