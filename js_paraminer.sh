#!/bin/bash
if [ $1  = "-h" ];
then 
    echo "[usage] ./js_paraminer.sh https://www.google.com"
    exit
else
    domain=$(echo "$1" | cut -d'/' -f3)
    echo "[+] Fetching JS files"
    echo $1 | getJS | tee -a "$domain"_jsfiles.txt
    echo "[+] Finding parameters from JS files"
    cat "$domain"_jsfiles.txt | xargs -I {} curl -s {} | grep -Po '(?<=(var )).*(?= =)' | uniq | tee -a "$domain"_parameters.txt
    echo "[+] Task Completed"
    echo "[+] Result saved to $domain"_parameters.txt
fi
