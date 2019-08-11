#!/bin/bash

# A Shell Script to Install all needed application to fully install a Debian version
# Maxime Bourguignon - 10/Aug/2019

# === Variables ===

# path to the list's file
path="./list"

declare -A map

# colors
red='\033[0;31m'
green='\033[0;32m'
blue='\033[0;34m'
nc='\033[0m'

# === Functions ===

# load group's files
function load(){
	# load files in directory
	echo ""
	cat $path/*.txt > $path/all.txt

	for file in $path/*
	do
		idx=${file##*/}
		idx=${idx%.*}
		map[$idx]=$file
	done

	keys=(${!map[@]})
	echo -e "${green}[groups]${nc} This group's file are loaded:"
	echo "${map[@]}"
}

# choose and install software's group
function ask(){
	# ask the group
	echo ""
	echo "What group would you like to install ?"
	echo -e "${blue}${keys[@]}${nc}"
	read -p "group software : " file

	softwares=()

	if [ ${map[$file]+_} ];
	then
		while IFS= read -r line
		do
			[[ "$line" =~ ^#.*$ ]] || softwares+=("$line")
		done < "${map[$file]}";
	else
		echo -e "${red}[error]${nc} Please try again"
		ask;		
	fi

	echo "${softwares[@]}"
	apt install ${softwares[@]}
}

# === Script ===

# restart with root privilege if no root
echo -e "${green}[root]${nc} Please run the script as root"
echo "$(whoami)"
[ "$EUID" -eq 0 ] || exec sudo "$0" "$@"

# Check the repository sources files in '/etc/apt/sources.list'
echo ""
echo -e "${green}[repository]${nc} Please check the apt repository"

load

# update and upgrade
echo ""
echo -e "${green}[update]${nc} updating the repositories"
apt -yq update >> /dev/null
echo -e "${green}[update]${nc} upgrading the softwares"
apt -yq upgrade >> /dev/null

ask

# delete file all (owner is root)
rm $path/all.txt

exit
