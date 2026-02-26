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
		
		if systemctl is-active --quiet apache2 || systemctl is-active --quiet nginx || systemctl is-active --quiet lighttpd;
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
					loop="false"
			elif [ "$server_select" = "2" ]
				then
					sudo apt install curl gnupg2 ca-certificates lsb-release ubuntu-keyring
					
					sleep 0.5
					
					curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor | sudo tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null
					
					sleep 0.5
					
					gpg --dry-run --quiet --no-keyring --import --import-options import-show /usr/share/keyrings/nginx-archive-keyring.gpg
					
					sleep 0.5
					
					echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] https://nginx.org/packages/ubuntu `lsb_release -cs` nginx" | sudo tee /etc/apt/sources.list.d/nginx.list
					
					sleep 0.5
					
					echo -e "Package: *\nPin: origin nginx.org\nPin: release o=nginx\nPin-Priority: 900\n" | sudo tee /etc/apt/preferences.d/99nginx
					
					sleep 0.5
					
					sudo apt update
					sudo apt install nginx -y
			elif [ "$server_select" = "3" ]
				then
					sudo apt install lighttpd
					loop="false"
			fi
		fi
	done

