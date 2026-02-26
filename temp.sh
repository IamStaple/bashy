#!/bin/bash
	
echo "Welcome to Server Builder!"

echo ""

loop="true"
loading="Checking Sources..."

while [ "$loop" = "true" ]
	do
		echo -ne "${loading:0:17}\r"
			
		sleep 0.5
		
		echo -ne "${loading:0:18}\r"
		
		sleep 0.5
		
		echo -ne "$loading\r"
		
		sleep 0.5
		
		echo -ne "${loading:0:17}  \r"
		
		if ss -tuln | grep -q LISTEN;
			then
				echo "Working Server Found"
		else
			echo "No Server Found."
			echo "Start by adding one. Please select one of the options."
			echo "1. Apache"
			echo "2. Nginx"
			echo "3. Lighttpd"
			echo ""
			read -p "Enter value: " server_select
			
			while [ "$server_select" != 1 ] && [ "$server_select" != 2 ] && [ "$server_select" != 3 ]
				do
					echo "Invalid Input. Try Again."
					read -p "Enter value: " server_select
				done
				
			if [ "$server_select" = "1" ]
				then
					sudo apt install apache2
			elif [ "$server_select" = "2" ]
				then
					sudo apt install nginx
			elif [ "$server_select" = "3" ]
				then
					sudo apt install lighttpd
			fi
		fi
	done

