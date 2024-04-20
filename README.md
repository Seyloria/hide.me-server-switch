![Banner](/hide.me-sw-banner.png)

This small linux bash script lets you easily switch the hide.me VPN Server by making use of the official [Hide.me CLI VPN client for Linux](https://github.com/eventure/hide.client.linux) and its Linux Systemd integration.

![Showcase](/example-sw.jpg)

## Installation
Install the [Hide.me CLI VPN client for Linux](https://github.com/eventure/hide.client.linux) as described.

Navigate to where you want to store the script and serverlist inside your home directory and copy the following into your terminal to download the files:
```sh
curl -O  https://raw.githubusercontent.com/Seyloria/hide.me-server-switch/main/hide.me-sw.sh
curl -O  https://raw.githubusercontent.com/Seyloria/hide.me-server-switch/main/serverlist.txt
```

## Optional Settings
Additionally you can add the following line to your .bashrc or .zshrc:
```sh
alias vpn="~/your_path/inside_your_home_directory/for_example/hide.me-sw.sh"
```
This will create an alias with the name "vpn"(edit it to the name you like), you just have to customize the path to where you saved the hide.me-sw.sh inside your home directory.
Afterwards you can open up the script by simply typing "vpn" into your terminal.


You may wanna add a server region to be autoconnected on startup.
This can be achived by adding a systemd enable:
```sh
sudo systemctl enable hide.me@dk
```
The "dk" in here stands for the Denkmark server as an example, you can replace that with whatever server you'd like to use(see [Hide.me Server Locations](https://member.hide.me/en/server-status))
From now on the system will automatically connect to the Denmark hide.me Server on startup.(do not add more than one enable at the time, this will otherwise messup the connections!)
To reverse this, you can simply disable it and if you wish so, add another location as described once bevor:
```sh
sudo systemctl disable hide.me@dk
```
