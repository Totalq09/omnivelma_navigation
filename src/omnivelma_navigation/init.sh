#!/bin/sh

source ~/catkin_pw/devel/setup.bash
export GAZEBO_MODEL_PATH=$(pwd)/../omnivelma/src:$GAZEBO_MODEL_PATH
export GAZEBO_PLUGIN_PATH=$(pwd)/../omnivelma/src:$GAZEBO_PLUGIN_PATH
export GAZEBO_RESOURCE_PATH=$(pwd)/../omnivelma/src:$GAZEBO_RESOURCE_PATH
export PYTHONPATH=~/catkin_pw/devel/lib/python2.7/dist-packages:/usr/lib/python2.7:/opt/ros/kinetic/lib/python2.7/dist-packages:/usr/lib/python2.7/plat-x86_64-linux-gnu:/usr/lib/python2.7/lib-tk:/usr/lib/python2.7/lib-old:/usr/lib/python2.7/lib-dynload/:/usr/lib/python2.7/dist-packages:/usr/lib/python2.7/dist-packages/PILcompat:/usr/lib/python2.7/dist-packages/gtk-2.0
