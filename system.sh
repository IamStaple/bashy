#!/bin/sh

ROOT_DIR="/root"

if [ -d "$ROOT_DIR" ]
	then
	
	echo "Welcome to System Builder!"
	
	loop="true"
	loading="Checking Sources..."
	
	while [ "$loop" = "true" ]
		do
			echo -ne "${loading:0:17}\r"
			
			sleep 1
			
			echo -ne "${loading:0:18}\r"
			
			sleep 1
			
			echo -ne "$loading\r"
			
			sleep 1
			
			echo -ne "${loading:0:17}  \r"
		done
	
else
	echo "You are not authorized."
fi