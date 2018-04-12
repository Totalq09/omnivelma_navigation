cmake_minimum_required(VERSION 2.8.3)
project(human_obstacle_msgs)

## Compile as C++11, supported in ROS Kinetic and newer
add_compile_options(-std=c++11)

find_package(catkin REQUIRED COMPONENTS
    roscpp
    rospy
    geometry_msgs
    message_generation
)

add_message_files(
    FILES
    people_positions.msg
)

generate_messages(
    DEPENDENCIES
    geometry_msgs
)

catkin_package(
    CATKIN_DEPENDS
        roscpp
        rospy
        geometry_msgs
        message_runtime
)

