cmake_minimum_required(VERSION 3.12)
project(untitled1)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

set(CMAKE_PREFIX_PATH "/home/juv/Qt/6.9.0/gcc_64")

find_package(Qt6 COMPONENTS
        Core
        Gui
        Widgets
        REQUIRED)

add_executable(untitled1 main.cpp adminwindow.cpp dogmodel.cpp service.cpp userwindow.cpp)
target_link_libraries(untitled1
        Qt::Core
        Qt::Gui
        Qt::Widgets
)

