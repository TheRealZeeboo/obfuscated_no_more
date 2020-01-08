#!/bin/bash
echo
# Obfuscated URL is entered here.
read -p  "Please paste URL here: " input
#New variable created called $domain, URL is converted taking the XX/xx from http/https, and reaplacing it with http. Then [dot] is converted to . and brackets are removed.
domain=$(echo $input | sed 's/[xX]/t/'|sed 's/[xX]/t/'|sed 's/dot/./g'|sed 's/[][]//g')
echo
printf "\e[1m%s\e[0m%s\n"  "Here is your converted URL: "
echo  $domain
#New variable of $domain is created and if the obfuscated was entered with or without the http(s), this section will be able to find the host/IP information.
parsed=$(echo $domain |awk -F[/:] '{ if ( $4 ) {print $4} else {print $1} }')
sleep 1
echo
printf "\e[1m%s\e[0m%s\n" "The domain responds with the following IP(s): "
host -ta  "$parsed"
echo
#In the event the HTTP Header information is needed, pressing any key that is not N/n, will give that output. Note, if you are using this behind a corporate firewall, and the domain is already flagged, you will receive a 500 error when curl is run.
read -p "Would you like to show the HTTP Response Headers as well? " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Nn]$ ]]; then
echo
curl -I "$domain"
else
  exit 0
fi
