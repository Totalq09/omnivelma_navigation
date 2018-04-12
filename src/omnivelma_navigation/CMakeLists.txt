cmake_minimum_required(VERSION 2.8.3)
project(omnivelma_navigation)

## Compile as C++11, supported in ROS Kinetic and newer
add_compile_options(-std=c++11)

find_package(catkin REQUIRED COMPONENTS
  omnivelma_msgs
  roscpp
  geometry_msgs
  sensor_msgs
  human_obstacle_msgs
  nav_msgs
  tf
  actionlib_msgs
  move_base_msgs 
)

catkin_package(
	INCLUDE_DIRS include
	CATKIN_DEPENDS 
	geometry_msgs
	sensor_msgs
	roscpp 
	omnivelma_msgs
	human_obstacle_msgs
	nav_msgs
	tf
	actionlib_msgs
	move_base_msgs 
)

###########
## Build ##
###########

## Specify additional locations of header files
## Your package locations should be listed before other locations
include_directories(
# include
# ${catkin_INCLUDE_DIRS}
)

include_directories(include)
find_package(roscpp REQUIRED)
find_package(omnivelma_msgs REQUIRED)
find_package(geometry_msgs REQUIRED)
find_package(sensor_msgs REQUIRED)
find_package(human_obstacle_msgs REQUIRED)
find_package(actionlib_msgs REQUIRED)
find_package(move_base_msgs REQUIRED)

include_directories(${roscpp_INCLUDE_DIRS})
include_directories(${geometry_msgs_INCLUDE_DIRS})
include_directories(${sensor_msgs_INCLUDE_DIRS})
include_directories(${human_obstacle_INCLUDE_DIRS})
include_directories(${actionlib_msgs_INCLUDE_DIRS})
include_directories(${omnivelma_msgs_INCLUDE_DIRS})
include_directories(${catkin_INCLUDE_DIRS})
include_directories(${move_base_msgs_INCLUDE_DIRS})

set(CMAKE_CXX_FLAGS "-Wall -Wpedantic --std=c++14")
add_executable(omnivelma_speed_broadcaster src/omnivelma_speed_broadcaster.cpp)
target_link_libraries(omnivelma_speed_broadcaster ${catkin_LIBRARIES})

add_executable(omnivelma_tf_broadcaster src/omnivelma_tf_broadcaster.cpp)
target_link_libraries(omnivelma_tf_broadcaster ${catkin_LIBRARIES})

add_executable(laser_tf_broadcaster src/laser_tf_broadcaster.cpp)
target_link_libraries(laser_tf_broadcaster ${catkin_LIBRARIES})

add_executable(camera_tf_broadcaster src/camera_tf_broadcaster.cpp)
target_link_libraries(camera_tf_broadcaster ${catkin_LIBRARIES})

add_executable(main_controller src/main_controller.cpp)
target_link_libraries(main_controller ${catkin_LIBRARIES})

add_executable(kinect_follower src/kinect_follower.cpp)
target_link_libraries(kinect_follower ${catkin_LIBRARIES})