#!/bin/sh

ROOT_DIR="/root"

if [ -d "$ROOT_DIR" ]
	then
	
	echo "Welcome to System Builder!"
	
	loop="true"
	
	while [ "$loop" = "true" ]
		do
			loading="..."
			
			echo "$loading"
			
			sleep 1
			
			echo "$loading:0:1"
			
			sleep 1
			
			echo "$loading:0:0"
			
			sleep 1
		done
	
else
	echo "You are not authorized."
fi