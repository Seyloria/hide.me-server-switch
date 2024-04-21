#!/usr/bin/env bash
# gets the basic data to work with:
get_workingdir=${0%/*}
workingdir="$get_workingdir/serverlist.txt"
currentserver=$(systemctl list-units --type=service --state=running | grep -w "hide")
currentshort=${currentserver:95:2}
currentauto=$(systemctl list-unit-files --type=service --state=enabled | grep -w "hide")
currentautoshort=${currentauto:8:2}
currentextip=$(curl -s -4 icanhazip.com)

echo -e '\n\E[37;46m'"\033[1m------------------------------------\033[0m"
echo -e '\E[37;46m'"\033[1m >> hide.me VPN Server Selection << \033[0m"
echo -e '\E[37;46m'"\033[1m------------------------------------\033[0m\n"
tput sgr0

servers=()
while IFS= read -r line; do
    servers+=("$line")
done < "$workingdir"
#done < "serverlist.txt"

declare -a servers_s
declare -a servers_l

for i in ${!servers[@]}; do
	servers_s+=("${servers[$i]:0:2}");
#	echo ${servers_s[$i]}
done

for i in ${!servers[@]}; do
	servers_l+=("${servers[$i]:3}");
#	echo ${servers_s[$i]}
done

#echo ${servers_s[0]}

# prints all servers in $servers_s
#for i in ${!servers_s[@]}; do
#	echo "${servers_s[$i]}";
#done

get_startup_vpn_name () {
	for i in ${!servers[@]}; do
		if [[ "${servers[i]:0:2}" == "$currentautoshort" ]];
		then
			echo "${servers[$i]}";
#			echo "{$i}";
		fi
	done
}

startup_vpn_full="$(get_startup_vpn_name)"

case "$startup_vpn_full" in
	"") echo -e "\033[1mSystem Startup VPN Server:\033[0m \E[1,31inactive\n"
	;;
	*) echo -e "\033[1mSystem Startup VPN Server:\033[0m ${startup_vpn_full:3}(${startup_vpn_full:0:2}) \n"
	;;
esac

get_current_vpn_name () {
	for i in ${!servers[@]}; do
		if [[ "${servers[i]:0:2}" == "$currentshort" ]];
		then
			echo "${servers[$i]}";
#			echo "{$i}";
		fi
	done
}

current_vpn_full="$(get_current_vpn_name)"

case "$current_vpn_full" in
	"") echo -e "\033[1mCurrent VPN Server:\033[0m \E[31;1minactive\n"
	;;
	*) echo -e "\033[1mCurrent VPN Server:\033[0m ${current_vpn_full:3}(${current_vpn_full:0:2} - $currentextip) \n"
	;;
esac
tput sgr0
servers_total=${#servers[@]}
#echo -e "\033[1mTotal Servers:\033[0m $servers_total\n"

show_menu() {
PS3="Select an option: "
	select server in "${servers_l[@]}" "Disconnect VPN" "Quit"; do
		if [[ "$REPLY" -le ${#servers_l[@]} ]]; then
			if [ "$currentshort" == "" ];
						then
#        					This triggers when there is currently no VPN connection
							sudo systemctl start hide.me@${servers_s[(($REPLY - 1))]}
        				else
#							This triggers when there is currently a VPN connection
#							echo "$currentshort - currently"
							sudo systemctl stop hide.me@$currentshort
#							echo "systemd stop $currentshort"
							sudo systemctl start hide.me@${servers_s[(($REPLY - 1))]}
#							echo "systemd connected to $currentshort"
						fi
						echo "Connected to the" $server "Server!"
						exit 0
			echo "You selected: $server"
			echo "bye.."
			exit 0
		elif [[ "$REPLY" -eq $(( ${#servers_l[@]} + 1 )) ]]; then
			if [ "$currentshort" == "" ];
						then
							echo "Nothing to stop here..."
							break
						else
							sudo systemctl stop hide.me@$currentshort
							echo "VPN Connection terminated!"	
						fi
			echo "bye.."
			exit 0
		elif [[ "$REPLY" -eq $(( ${#servers_l[@]} + 2 )) ]]; then
			echo "Quitting bye..."
			exit 0
		else
			echo "Invalid option. Please select a option between 1 and ${#servers[@]}, or $(( ${#servers[@]} + 2 )) to Quit."
		fi
	done
}

# Main script
while true; do
    show_menu
done
