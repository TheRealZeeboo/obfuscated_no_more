#!/usr/bin/env bash
read -p "Please enter malformed URL here: " input

#Entering the URL here will remove the brackest [] and then convert everything to lowercase.
domain=$(echo $input |awk '{print tolower($0)}'| sed 's/xx/tt/g'|sed 's/[][]//g')
echo
echo "Here is your converted URL: " $domain

parsed=$(echo $domain | awk -F[/:] '{print $4}')
sleep 1
read -p "Would you like to ping the domain as well? " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Nn]$ ]]; then
ping -c 3 "$parsed"
else
  exit 0
fi
