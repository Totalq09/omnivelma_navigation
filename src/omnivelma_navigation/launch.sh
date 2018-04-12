#!/bin/bash

#uruchom gazebo, a nastepnie zalezne node'y
#pliki launch rosa nie obsługują delaya miedzy ladowaniami node'ow, co generuje bledy


roslaunch omnivelma_navigation omnivelma.launch &
PIDGAZ=$!
read -n 1 -p "Press any button to continue loading..." -s
roslaunch omnivelma_navigation move_base.launch &
PIDWID=$!
roslaunch omnivelma_navigation detectors.launch &
PIDDET=$!

trap "kill $PIDDET; kill $PIDWID; kill $PIDGAZ;" SIGINT 
echo "Wciśnij ^C, aby wyłączyć procesy"
sleep infinity

