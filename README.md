# hide.me-server-switch
This small linux bash script lets you easily switch the hide.me VPN Server by making use of the official [Hide.me CLI VPN client for Linux](https://github.com/eventure/hide.client.linux) and its Linux Systemd integration.

## Installation
Copy this into your terminal to download the bash script file:
```sh
curl -O  https://raw.githubusercontent.com/Seyloria/hide.me-server-switch/main/hide.me-sw.sh
```

Additionally you can add the following line to your .bashrc or .zshrc:
```sh
alias vpn="~/your_path/inside_your_home_directory/for_example/hide.me-sw.sh"
```
This will create an alias with the name "vpn"(edit it to the name you like), you just have to customize the path to where you saved the hide.me-sw.sh inside your home directory.
Afterwards you can open up the script by simply typing "vpn" into your terminal.
