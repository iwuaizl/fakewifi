#!/bin/bash

printf "\e[1;36m __        __  _    __   _ \e[1;32m  _____           _                  \e[0m\n"
printf "\e[1;36m \ \      / / (_)  / _| (_)\e[1;32m |  ___|   __ _  | | __   ___   _ __ \e[0m\n"
printf "\e[1;36m  \ \ /\ / /  | | | |_  | |\e[1;32m | |_     / _' | | |/ /  / _ \ | '__|\e[0m\n"
printf "\e[1;36m   \ V  V /   | | |  _| | |\e[1;32m |  _|   | (_| | |   <  |  __/ | |   \e[0m\n"
printf "\e[1;34m    \_/\_/    |_| |_|   |_|\e[1;33m |_|      \__,_| |_|\_\  \___| |_|  \e[0m\n" 
printf "\n"
printf "\e[1;77m\e[43mWifi Faker v1.0, Author: @iwuaizl (Github/Twitter) \e[0m\n\n"           #hey its me

# Check virtual interface 'mon0'

fake=$(cat /sys/class/net/mon0/carrier)
printf '\e[1;92mChecking virtual interface... \e[0m'
sleep 1

if [ $fake ]
then
	printf '\e[1;92mOK\e[0m \n'
	sleep 1
else
	printf '\e[1;31mERROR\e[0m \n'
	printf '\e[1;92mCreating virtual interface (\e[34mmon0\e[92m)... '
	sleep 1
	iw wlan0 interface add mon0 type monitor		 # Add virtual interface
	printf '\e[1;92mOK\e[0m \n'
	sleep 1
fi

# Get list

read -p $'\e[1;92mGenerate list? (y/n): \e[0m' wlist

if [ $wlist == "y" ]
then
	read -p $'\e[1;92mWifi base name: \e[0m' wifi
	fn="$wifi@"
	size=${#fn}
	printf '\e[1;92mGenerating list (\e[1;34m%s\e[1;92m)... \e[1;0m' $wifi
	crunch 2>/dev/null $size $size 0123456789 -t $fn -o wifi.lst		# Gen list using crunch
	printf '\e[1;92mOK\e[0m\n'
	sleep 1
else
	read -p $'\e[1;92mPath to wifi name list: \e[0m' wpath
	wpath=${wpath}
	chmod a+x $wpath
fi

printf '\n\e[1;92mStarting the attack... (\e[31mCtrl+C to stop\e[92m)\e[0m \n\n'
sleep 1
if [ $wlist == "y" ]
then
	mdk3 mon0 b -f wifi.lst
else
	mdk3 mon0 b -f $wpath
fi

#1 by iwuaizl
