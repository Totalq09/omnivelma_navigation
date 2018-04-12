cmake_minimum_required(VERSION 2.8.3)
project(object_detector)

## Compile as C++11, supported in ROS Kinetic and newer
add_compile_options(-std=c++11)

## Find catkin macros and libraries
## if COMPONENTS list like find_package(catkin REQUIRED COMPONENTS xyz)
## is used, also find other catkin packages
find_package(catkin REQUIRED COMPONENTS
  geometry_msgs
  roscpp
  cv_bridge
  rospy
  std_msgs
  sensor_msgs
  image_transport
  tf
  visualization_msgs
  people_msgs
)

catkin_package(
	INCLUDE_DIRS include
	CATKIN_DEPENDS 
	geometry_msgs
	sensor_msgs
	roscpp 
  rospy
	image_transport
  cv_bridge
  tf
  visualization_msgs
  people_msgs
)

find_package(Boost REQUIRED COMPONENTS signals system thread)
find_package(OpenCV)

include_directories(include)
include_directories(
  include
  ${Boost_INCLUDE_DIRS}
  ${OpenCV_INCLUDE_DIRS}
  ${catkin_INCLUDE_DIRS}
)

include(/home/pwalas1/dlib/dlib/cmake)
set(USE_AVX_INSTRUCTIONS 1)

include_directories(${catkin_INCLUDE_DIRS})

add_executable(object_detector src/object_detector.cpp)
target_link_libraries(object_detector ${Boost_LIBRARIES} ${OpenCV_LIBRARIES} ${catkin_LIBRARIES} dlib)
