Sure, here's the contents for the file: /sorted-map-bst/sorted-map-bst/CMakeLists.txt

cmake_minimum_required(VERSION 3.10)

project(SortedMapBST)

set(CMAKE_CXX_STANDARD 11)

include_directories(src/headers)

file(GLOB SOURCES "src/implementations/*.cpp" "src/App.cpp")

add_executable(SortedMapBST ${SOURCES})