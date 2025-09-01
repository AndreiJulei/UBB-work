cmake_minimum_required(VERSION 3.30)

project(QtOOPApp)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_PREFIX_PATH "/Users/juv/Documents/Qt/6.9.0/macos")

find_package(Qt6 COMPONENTS
  Core
  Gui
  Widgets
  REQUIRED)

add_executable(QtOOPApp
  main.cpp
  domain.cpp
  mainWindow.cpp
  repository.cpp
  observer.h
  service.cpp
)

set_property(TARGET QtOOPApp PROPERTY CMAKE_AUTOUIC OFF)


target_link_libraries(QtOOPApp
  Qt::Core
  Qt::Gui
  Qt::Widgets
)

