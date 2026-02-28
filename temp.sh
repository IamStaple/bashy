#!/bin/bash
	
echo "Welcome to Server Builder!"

echo ""

loop="true"
loading="Checking Sources..."

package_loading="Checking available server package manager..."

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
				break
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
					sudo apt install apache2 -y
					loop="false"
			elif [ "$server_select" = "2" ]
				then
					sudo apt install curl gnupg2 ca-certificates lsb-release ubuntu-keyring -y
					
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
					
					loop="false"
			elif [ "$server_select" = "3" ]
				then
					sudo apt install lighttpd -y
					loop="false"
					
				
				package_loop="true"
				
				while [ "$package_loop" = "true" ]
					do
						echo "${package_loading:0:42}"
						
						sleep 0.5
						
						echo "${package_loading:0:43}"
						
						sleep 0.5
						
						echo "$package_loading"
						
						sleep 0.5
						
						package_loop="false"
					done
				
				
			fi
		fi
		echo ""
		echo "Choose Your Preferred Package Manager: "
		echo "1. Npm"
		echo "2. Pip"
		
		read -p "Enter Value: " package_input
		
		while [ "$package_input" != "1" ] && [ "$package_input" != "2" ]
			do
				echo "Invalid Input. Try Again."
				read -p "Enter Value: " package_input
			done
		
		if [ "$package_input" = "1" ]
			then
				if ! dpkg -l | grep nodejs 
					then
						sudo apt install nodejs -y
						sudo apt install npm -y
						
						if [ ! -d /var/www/html/nodejs ] 
							then
								sudo mkdir /var/www/html/nodejs
								sudo touch /var/www/html/nodejs/index.js
								echo ""
								echo "Created a directory at /var/www/html"
								echo "Directory Name: nodejs"
								echo "Created index.js at nodejs directory"
						fi
						
						echo "Package Installation Successful."
				else 
					echo "Package already installed. Installation Satisfied"
				fi
				
				echo "Checking existing directory..."
				sleep 2
				echo ""
				latest_folder=$(ls -d /var/www/html/nodejs/project* 2>/dev/null | sort -V | tail -n 1)
				
				if [[ -z "$latest_folder" ]]
					then
						next_num=1
				else
					number=${latest_folder##*/project}
					next_num=$((number + 1))
				fi
				
				new_project="project$next_num"
				
				sudo mkdir /var/www/html/nodejs/"$new_project"
				echo "Created $new_project at nodejs directory"
				echo "Running npm setup for Vite bundler..."
				sudo npm --prefix /var/www/html/"$new_project" create vite@latest . -- --template react-ts --yes
				
				echo "Running vite build..."
				sudo npm --prefix /var/www/html/nodejs/"$new_project" run build
				
				ipa=$(ip a | grep 'inet 192.168' | awk '{print $2}' | cut -d/ -f1)
				
				echo "Application can be found on $ipa/nodejs/$new_project/dist/"
				
		elif [ "$package_input" = "2" ]
			then
				if ! dpkg -l | grep python3
					then
						sudo apt install python3-pip -y
						sudo apt install python3-venv -y
						
						if [ ! -d /var/www/html/python ]
							then 
								sudo mkdir /var/www/html/python
								sudo touch /var/www/html/python/main.py
								echo ""
								echo "Created a directory at /var/www/html"
								echo "Directory name: python"
								echo "Created main.py at python directory"
						fi
						
						echo "Package Installation Successful"
				else
					echo "Package already installed. Installation Satisfied"
				fi
		fi
	done

