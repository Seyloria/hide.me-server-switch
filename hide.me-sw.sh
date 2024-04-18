#!/usr/bin/env bash

currentserver=$(systemctl list-units --type=service --state=running | grep -w "hide")
currentshort=${currentserver:95:2}
currentauto=$(systemctl list-unit-files --type=service --state=enabled | grep -w "hide")
currentautoshort=${currentauto:8:2}
currentextip=$(curl -s -4 icanhazip.com)

echo -e '\n\E[37;46m'"\033[1m------------------------------------\033[0m"
echo -e '\E[37;46m'"\033[1m >> hide.me VPN Server Selection << \033[0m"
echo -e '\E[37;46m'"\033[1m------------------------------------\033[0m\n"
tput sgr0

case "$currentautoshort" in
	"") echo -e "\033[1mSystem Startup Server:\033[0m Nothing defined\n"
	;;
	"at") echo -e "\033[1mSystem Startup Server:\033[0m Austria Server\n"
	;;
	"be") echo -e "\033[1mSystem Startup Server:\033[0m Belgium Server\n"
	;;
	"dk") echo -e "\033[1mSystem Startup Server:\033[0m Denmark Server\n"
	;;
	"de") echo -e "\033[1mSystem Startup Server:\033[0m Germany Server\n"
	;;
esac


case "$currentshort" in
	"") echo -e "\033[1mCurrent VPN Server:\033[0m Not connected to any hide.me VPN Server\n"
	;;
	"at") echo -e "\033[1mCurrent VPN Server:\033[0m Austria Server\n"
	;;
	"be") echo -e "\033[1mCurrent VPN Server:\033[0m Belgium Server\n"
	;;
	"dk") echo -e "\033[1mCurrent VPN Server:\033[0m Denmark Server\n"
	;;
	"de") echo -e "\033[1mCurrent VPN Server:\033[0m Germany Server\n"
	;;
esac

echo -e "\033[1mCurrent External IP:\033[0m $currentextip\n"
tput sgr0

PS3="Select the hide.me VPN-Server location you want to use:"

select server in "Austria" "Belgium" "Denmark" "Germany" "Stop VPN Connection" "Quit"; do
	case $server in
		Austria)
			if [ "$currentshort" == "" ];
			then 
				sudo systemctl start hide.me@at
			else
				sudo systemctl stop hide.me@$currentshort
				sudo systemctl start hide.me@at
			fi
			echo "Connected to the" $server "Server!"
			break
			;;
		Belgium)
			if [ "$currentshort" == "" ];
			then 
				sudo systemctl start hide.me@be
			else
				sudo systemctl stop hide.me@$currentshort
				sudo systemctl start hide.me@be
			fi
			echo "Connected to the" $server "Server!"
			break
			;;
		Denmark)
			if [ "$currentshort" == "" ];
			then 
				sudo systemctl start hide.me@dk
			else
				sudo systemctl stop hide.me@$currentshort
				sudo systemctl start hide.me@dk
			fi
			echo "Connected to the" $server "Server!"
			break
			;;
		Germany)
			if [ "$currentshort" == "" ];
			then 
				sudo systemctl start hide.me@de
			else
				sudo systemctl stop hide.me@$currentshort
				sudo systemctl start hide.me@de
			fi
			echo "Connected to the" $server "Server!"
			break
			;;
		"Stop VPN Connection")
			if [ "$currentshort" == "" ];
			then 
				echo "nothing to stop here..."
			else
				sudo systemctl stop hide.me@$currentshort
				echo "VPN-Connection terminated!"	
			fi
			;;
		Quit)
			echo "bye.."
			break
			;;
		*) 
			echo "$REPLY is not a valid option, please select another option."
			;;
	esac
done
