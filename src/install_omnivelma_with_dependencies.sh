#!/bin/sh

printf "\npreparation started\n"
sleep 1

sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get -y update

printf "\n\npreparation done\n"
printf "ros installation started\n\n"
sleep 3

sudo apt-get -y install ros-kinetic-desktop-full
sudo apt-get -y install python-rosinstall python-rosinstall-generator python-wstool build-essential

sudo apt-get -y install ros-kinetic-ecl

sudo apt-get -y install ros-kinetic-slam-gmapping

sudo apt-get -y install ros-kinetic-teb-local-planner
sudo apt-get -y install ros-kinetic-eband-local-planner

sudo apt-get -y install ros-kinetic-gazebo-ros-pkgs ros-kinetic-gazebo-ros-control
sudo apt-get -y install ros-kinetic-rqt-tf-tree
sudo apt-get -y install ros-kinetic-rviz
sudo apt-get -y install ros-kinetic-navigation


sudo rosdep init
rosdep update

printf "\n\nros installation done\n"
printf "opencv depends installation started\n\n"
sleep 3

sudo apt-get -y install build-essential checkinstall cmake pkg-config yasm
sudo apt-get -y install git gfortran
sudo apt-get -y install libjpeg8-dev libjasper-dev libpng12-dev

# If you are using Ubuntu 14.04
sudo apt-get -y install libtiff4-dev
# If you are using Ubuntu 16.04
sudo apt-get -y install libtiff5-dev

sudo apt-get -y install libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev
sudo apt-get -y install libxine2-dev libv4l-dev
sudo apt-get -y install libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev
sudo apt-get -y install qt5-default libgtk2.0-dev libtbb-dev
sudo apt-get -y install libatlas-base-dev
sudo apt-get -y install libfaac-dev libmp3lame-dev libtheora-dev
sudo apt-get -y install libvorbis-dev libxvidcore-dev
sudo apt-get -y install libopencore-amrnb-dev libopencore-amrwb-dev
sudo apt-get -y install x264 v4l-utils
 
# Optional dependencies
sudo apt-get -y install libprotobuf-dev protobuf-compiler
sudo apt-get -y install libgoogle-glog-dev libgflags-dev
sudo apt-get -y install libgphoto2-dev libeigen3-dev libhdf5-dev doxygen

sudo apt-get -y install python-dev python-pip python3-dev python3-pip
sudo -H pip2 install -U pip numpy
sudo -H pip3 install -U pip numpy

printf "\n\nopencv depends installation done\n"
printf "additional packages installation started\n\n"
sleep 3

sudo apt-get -y install freeglut3-dev pkg-config build-essential libxmu-dev libxi-dev libusb-1.0-0-dev doxygen graphviz mono-complete
sudo apt-get -y install libbullet-dev
sudo apt-get -y install libsdl2-2.0
sudo apt-get -y install libsdl2-dev
sudo apt-get -y install libsdl1.2-dbg
sudo apt-get -y install libsdl-image1.2-dev
sudo apt-get -y install libsdl-dev
sudo apt-get -y install code
printf "\n\nadditional packages installation done\n\n"
sleep 1

