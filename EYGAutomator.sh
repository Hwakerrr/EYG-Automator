#!/bin/sh
#by yathu.g.krishna

# Define ANSI color variables
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m'
origIFS="${IFS}"



printf "${RED}---------------------(Frontend Controls-11.5,16.4)---------------------\n"
printf "${GREEN}---------------------Default Port Scan---------------------\n"
printf "${NC}\n"

#nmap -sS -sV $1

printf "${GREEN}---------------------Full Port Scan---------------------\n"
printf "${NC}\n"

#nmap -p0-65535 $1

printf "${RED}---------------------(Frontend Controls-11.8)---------------------\n"
printf "${GREEN}---------------------Insecure ports FTP(21),Telnet(23),SSH(22),RemoteShell(514) check---------------------\n"
printf "${NC}\n"

nmap -p21,23,22,514 -sV $1


printf "${RED}---------------------(Frontend Controls-11.9)---------------------\n"
printf "${GREEN}---------------------Vulnerable SMB(139,445) version check---------------------\n"
printf "${NC}\n"

nmap -p139,445 --script smb-protocols $1

printf "${RED}---------------------(Frontend Controls-10.2)---------------------\n"
printf "${GREEN}--------------------TLS certificate check---------------------\n"
printf "${NC}\n"

nmap --script ssl-cert -p443 $1

printf "${RED}---------------------(Frontend Controls-16.12)---------------------\n"
printf "${GREEN}---------------------Weak TLS cipher check---------------------\n"
printf "${NC}\n"

nmap --script ssl-enum-ciphers -p443 $1

printf "${RED}---------------------(Frontend Controls-14.3,16.15)---------------------\n"
printf "${GREEN}---------------------Unauthenticated directory enumeration---------------------\n"
printf "${NC}\n"

dirb https://$1 common.txt

