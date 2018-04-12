cmake_minimum_required(VERSION 2.8.3)
project(inflated_merger)

## Compile as C++11, supported in ROS Kinetic and newer
add_compile_options(-std=c++11)

find_package(catkin REQUIRED COMPONENTS
  costmap_2d
  dynamic_reconfigure
  roscpp
)

include_directories(
 include
  ${catkin_INCLUDE_DIRS}
)

add_library(inflated_merger src/inflated_merger.cpp)