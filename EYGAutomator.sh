#!/bin/sh
#by yathu.g.krishna
printf "${NC}\n"
printf "${NC}\n"
printf "${NC}\n" 

# Define ANSI color variables
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m'
origIFS="${IFS}"

export mynmap="/mnt/c/Program Files (x86)/Nmap/nmap.exe"

printf "${YELLOW}=======================================>(Frontend Controls-11.5,16.4)<=======================================>\n"
printf "${GREEN}---------------------Default Port Scan---------------------\n"
printf "${NC}\n"

"${mynmap}" -sS -sV $1

printf "${NC}\n"
printf "${GREEN}---------------------Full Port Scan---------------------\n"
printf "${NC}\n"

"${mynmap}" -p0-65535 $1

printf "${NC}\n"
printf "${YELLOW}=======================================>(Frontend Controls-11.8)<=======================================\n"
printf "${GREEN}---------------------Insecure ports FTP(21),Telnet(23),SSH(22),RemoteShell(514) check---------------------\n"
printf "${NC}\n"

"${mynmap}" -p21,23,22,514 -sV $1

printf "${NC}\n"
printf "${YELLOW}=======================================>(Frontend Controls-11.9)<=======================================\n"
printf "${GREEN}---------------------Vulnerable SMB(139,445) version check---------------------\n"
printf "${NC}\n"

"${mynmap}" -p139,445 --script smb-protocols $1

printf "${NC}\n"
printf "${YELLOW}=======================================>(Frontend Controls-10.2)<=======================================\n"
printf "${GREEN}--------------------TLS certificate check---------------------\n"
printf "${NC}\n"

"${mynmap}" --script ssl-cert -p443 $1

printf "${NC}\n"
printf "${GREEN}---------------------Sending request via HTTP---------------------\n"
printf "${NC}\n"

printf "${RED}Request -> curl -i http://${1}\n"
printf "${NC}\n"
curl -i http://$1 



printf "${NC}\n"
printf "${YELLOW}=======================================>(Frontend Controls-16.12)<=======================================\n"
printf "${GREEN}----------------------Weak TLS cipher check----------------------\n"
printf "${NC}\n"

"${mynmap}" --script ssl-enum-ciphers -p443 $1

printf "${NC}\n"
printf "${YELLOW}=======================================>(Frontend Controls-14.3,16.15)<=======================================\n"
printf "${GREEN}---------------------Unauthenticated directory enumeration---------------------\n"
printf "${NC}\n"

dirb https://$1 common.txt

dirb https://$1 big.txt

#dirb https://$1 $2

printf "${NC}\n"
printf "${YELLOW}=======================================>(Frontend Controls-11.6,14.7,16.14)<=======================================\n"
printf "${GREEN}---------------------Response Headers---------------------\n"
printf "${NC}\n"

curl -k -X HEAD -i https://$1 | awk  '{for(i=1;i<=NF;i++){ if($i~/server:/) $i=sprintf("\033[0;31m%s\033[0;00m",$i)}; print}' 

printf "${NC}\n"
printf "${YELLOW}=======================================>(Frontend Controls-16.9)<=======================================\n"
printf "${GREEN}---------------------Response Headers---------------------\n"
printf "${NC}\n"

curl -k -X OPTIONS -i https://$1