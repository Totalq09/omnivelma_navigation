cmake_minimum_required(VERSION 2.8.3)
project(human_obstacle)

## Compile as C++11, supported in ROS Kinetic and newer
add_compile_options(-std=c++11)

find_package(catkin REQUIRED COMPONENTS
    costmap_2d
    cmake_modules
    dynamic_reconfigure
    geometry_msgs
    laser_geometry
    map_msgs
    message_filters
    message_generation
    human_obstacle_msgs
    nav_msgs
    pcl_conversions
    pcl_ros
    pluginlib
    roscpp
    sensor_msgs
    std_msgs
    tf
    visualization_msgs
    voxel_grid
    people_msgs
)

find_package(message_filters REQUIRED)

find_package(PCL REQUIRED)
remove_definitions(-DDISABLE_LIBUSB-1.0)
find_package(Eigen3 REQUIRED)
find_package(Boost REQUIRED COMPONENTS system thread)
include_directories(
    include
    ${catkin_INCLUDE_DIRS}
    ${EIGEN3_INCLUDE_DIRS}
    ${PCL_INCLUDE_DIRS}
    ${Boost_INCLUDE_DIRS}
)

add_definitions(${EIGEN3_DEFINITIONS})

generate_dynamic_reconfigure_options(
    cfg/human_layer.cfg
)

catkin_package(
    INCLUDE_DIRS
        include
    #LIBRARIES costmap_2d layers
    LIBRARIES {PROJECT_NAME}
    CATKIN_DEPENDS
        dynamic_reconfigure
        geometry_msgs
        laser_geometry
        map_msgs
        message_filters
        message_runtime
        human_obstacle_msgs
        nav_msgs
        pcl_ros
        pluginlib
        roscpp
        sensor_msgs
        std_msgs
        tf
        visualization_msgs
        voxel_grid
        people_msgs
    DEPENDS
        PCL
        EIGEN3
        Boost
)

include_directories(${catkin_INCLUDE_DIRS} include)

###########
## Build ##
###########


add_library(human_layer src/human_layer.cpp)
add_library(obstacle_with_human_layer src/obstacle_with_human_layer.cpp)

target_link_libraries(human_layer
  ${PCL_LIBRARIES}
  ${Boost_LIBRARIES}
  ${catkin_LIBRARIES}
)

target_link_libraries(obstacle_with_human_layer
  ${PCL_LIBRARIES}
  ${Boost_LIBRARIES}
  ${catkin_LIBRARIES}
)

add_dependencies(human_layer ${PROJECT_NAME}_gencfg)

add_executable(people_merger src/people_merger.cpp)
target_link_libraries(people_merger ${catkin_LIBRARIES})