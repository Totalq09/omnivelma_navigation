cmake_minimum_required(VERSION 2.8.3)
project(body_detector)

add_compile_options(-std=c++11)

find_package(catkin REQUIRED COMPONENTS
  actionlib
  actionlib_msgs
  cv_bridge
  geometry_msgs
  image_transport
  people_msgs
  roscpp
  rospy
  sensor_msgs
  std_msgs
  tf
)

find_package(OpenCV REQUIRED)

catkin_package(
#  INCLUDE_DIRS include
#  LIBRARIES body_detector
#  CATKIN_DEPENDS actionlib actionlib_msgs cv_bridge geometry_msgs image_transport people_msgs roscpp rospy sensor_msgs std_msgs tf
#  DEPENDS system_lib
)

include_directories(
  include
  ${OpenCV_INCLUDE_DIRS}
  ${catkin_INCLUDE_DIRS}
)

add_executable(body_detector
  src/body_detector.cpp)

target_link_libraries(body_detector
  ${catkin_LIBRARIES}
  ${OpenCV_LIBRARIES})

install(TARGETS
  body_detector
  DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)
