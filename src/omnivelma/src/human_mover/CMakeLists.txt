cmake_minimum_required(VERSION 2.8.3)
project(human_mover)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  geometry_msgs
  std_msgs
  tf
  cv_bridge
  sensor_msgs
  image_transport
)

catkin_package(
	CATKIN_DEPENDS 
	geometry_msgs
	roscpp 
	std_msgs
	tf
	cv_bridge
	sensor_msgs
	image_transport
)

find_package(Boost REQUIRED COMPONENTS signals system thread)
find_package(OpenCV)
find_package(roscpp REQUIRED)
find_package(geometry_msgs REQUIRED)
find_package(std_msgs REQUIRED)
find_package(tf REQUIRED)

set(CMAKE_CXX_FLAGS  "-Wall -Wpedantic --std=c++14")
link_directories(${PROJECT_SOURCE_DIR}/lib)
include_directories(
	${PROJECT_SOURCE_DIR}/include 
	${Boost_INCLUDE_DIR} 
	${OpenCV_INCLUDE_DIRS} 
	${catkin_INCLUDE_DIRS})

add_executable(${PROJECT_NAME} src/mover.cpp)
target_link_libraries(${PROJECT_NAME}  
	${catkin_LIBRARIES} 
	${Boost_LIBRARIES} 
	${OpenCV_LIBRARIES})

target_link_libraries(${PROJECT_NAME}  
	sfml-graphics 
	sfml-window 
	sfml-system 
	pthread)

add_dependencies(${PROJECT_NAME} ${catkin_EXPORTED_TARGETS})