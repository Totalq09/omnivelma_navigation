#!/bin/bash

roslaunch omnivelma_navigation haar_detectors.launch &
PIDGAZ=$!

trap "kill $PIDWID;" SIGINT 
echo "Wciśnij ^C, aby wyłączyć procesy"
sleep infinity
