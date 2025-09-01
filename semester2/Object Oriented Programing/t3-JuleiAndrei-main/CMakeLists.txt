cmake_minimum_required(VERSION 3.30)

project(QtO1PApp)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_PREFIX_PATH "/Users/juv/Documents/Qt/6.9.0/macos")

find_package(Qt6 COMPONENTS
  Core
  Gui
  Widgets
  REQUIRED)

add_executable(QtO1PApp
  main.cpp
  domain.h
  repository.h
  service.h
  mainwindow.cpp
  mainwindow.h
)

set_property(TARGET QtO1PApp PROPERTY CMAKE_AUTOUIC OFF)


target_link_libraries(QtO1PApp
  Qt::Core
  Qt::Gui
  Qt::Widgets
)