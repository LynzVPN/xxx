#!/bin/bash
MYIP=$(curl -sS ipv4.icanhazip.com)
echo "Checking VPS"
#########################
# Color Validation
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White
UWhite='\033[4;37m'       # White

On_IPurple='\033[0;105m'  #
On_IRed='\033[0;101m'
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White
Yellow='\033[0;93'
NC='\e[0m'
# // Export Color & Information
export RED='\033[0;31m'
export GREEN='\033[0;32m'
export YELLOW='\033[0;33m'
export BLUE='\033[0;34m'
export PURPLE='\033[0;35m'
export CYAN='\033[0;36m'
export LIGHT='\033[0;37m'
export NC='\033[0m'
# VPS Information
UDPCORE="https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1S3IE25v_fyUfCLslnujFBSBMNunDHDk2' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1S3IE25v_fyUfCLslnujFBSBMNunDHDk2"
#Domain
domain=$(cat /etc/xray/domain)
#Status certificate
modifyTime=$(stat $HOME/.acme.sh/${domain}_ecc/${domain}.key | sed -n '7,6p' | awk '{print $2" "$3" "$4" "$5}')
modifyTime1=$(date +%s -d "${modifyTime}")
currentTime=$(date +%s)
stampDiff=$(expr ${currentTime} - ${modifyTime1})
days=$(expr ${stampDiff} / 86400)
remainingDays=$(expr 90 - ${days})
tlsStatus=${remainingDays}
if [[ ${remainingDays} -le 0 ]]; then
	tlsStatus="expired"
fi
# OS Uptime
uptime="$(uptime -p | cut -d " " -f 2-10)"
# Download
# Getting CPU Information
ttoday="$(vnstat | grep today | awk '{print $8" "substr ($9, 1, 3)}' | head -1)"
tmon="$(vnstat -m | grep `date +%G-%m` | awk '{print $8" "substr ($9, 1 ,3)}' | head -1)"
cpu_usage1="$(ps aux | awk 'BEGIN {sum=0} {sum+=$3}; END {print sum}')"
cpu_usage="$((${cpu_usage1/\.*} / ${corediilik:-1}))"
cpu_usage+=" %"
ISP=$(curl -s ipinfo.io/org?token=2e48a6d62556ca | cut -d " " -f 2-10 )
CITY=$(curl -s ipinfo.io/city?token=2e48a6d62556ca )
WKT=$(curl -s ipinfo.io/timezone?token=2e48a6d62556ca )
#os=$(curl-s "`hostnamectl | grep "Operating System" | cut -d ' ' -f5-`)
DAY=$(date +%A)
DATE=$(date +%m/%d/%Y)
DATE2=$(date -R | cut -d " " -f -5)
IPVPS=$(curl -s ipinfo.io/ip?token=2e48a6d62556ca )
cname=$( awk -F: '/model name/ {name=$2} END {print name}' /proc/cpuinfo )
cores=$( awk -F: '/model name/ {core++} END {print core}' /proc/cpuinfo )
freq=$( awk -F: ' /cpu MHz/ {freq=$2} END {print freq}' /proc/cpuinfo )
tram=$( free -m | awk 'NR==2 {print $2}' )
uram=$( free -m | awk 'NR==2 {print $3}' )
fram=$( free -m | awk 'NR==2 {print $4}' )

#KonZ
vlx=$(grep -c -E "^#vl# " "/etc/xray/config.json")
let vla=$vlx/2
vmc=$(grep -c -E "^#vm# " "/etc/xray/config.json")
let vma=$vmc/2
ssh1="$(awk -F: '$3 >= 1000 && $1 != "nobody" {print $1}' /etc/passwd | wc -l)"
trx=$(grep -c -E "^#tr# " "/etc/xray/config.json")
let tra=$trx/2
ssx=$(grep -c -E "^#ss# " "/etc/xray/config.json")
let ssa=$ssx/2

clear 
echo -e "${BIBlue} ┌─────────────────────────────────────────────────────┐${NC}"
echo -e "${BIBlue} │                  ${BIWhite}${BIWhite}Server Informations${NC}"
echo -e "${BIBlue} │"
echo -e " ${BIBlue}│  ${BIWhite}SCRIPT BY        :  ${BIWhite}LYNZ TUNNEL${NC}${BIBlue}        "
echo -e " ${BIBlue}│ ${NC} ${Cyan}Current Domain ${NC} ${BIWhite} :  ${YELLOW}$domain${NC}" 
echo -e " ${BIBlue}│ ${NC} ${Cyan}IP-VPS         ${NC} ${BIWhite} :  ${YELLOW}$IPVPS${NC}"                  
echo -e " ${BIBlue}│ ${NC} ${Cyan}ISP-VPS        ${NC} ${BIWhite} :  ${YELLOW}$ISP${NC}"
echo -e " ${BIBlue}│ ${NC} ${Cyan}DATE&TIME      ${NC} ${BIWhite} :  ${YELLOW}$( date -d "0 days" +"%d-%m-%Y | %X" ) ${NC}" 
echo -e " ${BIBlue}└─────────────────────────────────────────────────────┘${NC}"
echo -e "                   ${BIBlue}[${BIWhite}01${BIBlue}]${RED} •${NC} ${BIBlue}SSH MENU        $NC"
echo -e "                   ${BIBlue}[${BIWhite}02${BIBlue}]${RED} •${NC} ${BIBlue}VMESS MENU      $NC"
echo -e "                   ${BIBlue}[${BIWhite}03${BIBlue}]${RED} •${NC} ${BIBlue}VLESS MENU      $NC"
echo -e "                   ${BIBlue}[${BIWhite}04${BIBlue}]${RED} •${NC} ${BIBlue}TROJAN MENU     $NC"
echo -e "                   ${BIBlue}[${BIWhite}05${BIBlue}]${RED} •${NC} ${BIBlue}S-SOCK MENU     $NC"
echo -e "                   ${BIBlue}[${BIWhite}06${BIBlue}]${RED} •${NC} ${BIBlue}CEK RUNNING     $NC"
echo -e "                   ${BIBlue}[${BIWhite}07${BIBlue}]${RED} •${NC} ${BIBlue}CLEAR CACHE     $NC"
echo -e "                   ${BIBlue}[${BIWhite}08${BIBlue}]${RED} •${NC} ${BIBlue}MENU DOMAIN     $NC"
echo -e "                   ${BIBlue}[${BIWhite}09${BIBlue}]${RED} •${NC} ${BIBlue}SPEED TEST        $NC"
echo -e "                   ${BIBlue}[${BIWhite}10${BIBlue}]${RED} •${NC} ${BIBlue}SET AUTO REBOOT        $NC"
echo -e "                   ${BIBlue}[${BIWhite}11${BIBlue}]${RED} •${NC} ${BIBlue}RESTAR ALL SERVICE        $NC" 
echo -e "                   ${BIBlue}[${BIWhite}12${BIBlue}]${RED} •${NC} ${BIBlue}CEK BANDWIDTH        $NC"
echo -e "                   ${BIBlue}[${BIWhite}13${BIBlue}]${RED} •${NC} ${BIBlue}INSTALL UDP SERVICE        $NC"
echo -e "                   ${BIBlue}[${BIWhite}14${BIBlue}]${RED} •${NC} ${BIBlue}CERTV2RAY/ADD SSL        $NC"
echo -e "                   ${BIBlue}[${BIWhite}15${BIBlue}]${RED} •${NC} ${BIBlue}CHANGE BANNER        $NC"
echo -e "                   ${BIBlue}[${BIWhite}16${BIBlue}]${RED} •${NC} ${BIBlue}CHANGE PASSWORD        $NC"
echo -e "                   ${BIBlue}[${BIWhite}17${BIBlue}]${RED} •${NC} ${BIBlue}INSTALL TCP BBR        $NC"
echo -e "                   ${BIBlue}[${BIWhite}18${BIBlue}]${RED} •${NC} ${BIBlue}MENU BACKUP        $NC"
echo -e "                   ${BIBlue}[${BIWhite}X ${BIBlue}]${RED} •${NC} ${BIBlue}TYPE X FOR EXIT $NC"
echo -e " ${BIBlue} ┌─────────────────────────────────────────────────────┐${NC}"
echo -e " ${BIBlue} │  \033[0m ${BOLD}${BIWhite}XXX${BIBlue} SSH${BIWhite}  XXX  ${BIBlue}VMESS  ${BIWhite}XXX  ${BIBlue}VLESS  ${BIWhite}XXX  ${BIBlue}TROJAN${BIWhite} XXX $NC "
echo -e " ${BIBlue} │  \033[0m ${Blue}     $ssh1         $vma           $vla           $tra              $NC"
echo -e " ${BIBlue} └─────────────────────────────────────────────────────┘${NC}"
echo -e "          ${BIBlue}┌─────────────────────────────────────┐${NC}"
echo -e "          ${BIBlue}│  Version      ${NC} : Ver3. Last Update"
echo -e "          ${BIBlue}│  User       ${NC}   :\033[1;36m $Name Lynz 001\e[0m"
echo -e "          ${BIBlue}│  Expiry script${NC} : ${BIYellow}$Exp${NC} LIFETIME"
echo -e "          ${BIBlue}└─────────────────────────────────────┘${NC}"

echo -e   ""
read -p " Select menu :  "  opt
echo -e   ""
case $opt in
1) clear ; m-sshovpn ;;
2) clear ; m-vmess ;;
3) clear ; m-vless ;;
4) clear ; m-trojan ;;
5) clear ; m-ssws ;;
6) clear ; running ;;
7) clear ; clearcache ;;
8) clear ; m-domain ;;
9) clear ; speedtest ;;
10) clear ; auto-reboot ;;
11) clear ; restart ;;
12) clear ; bw ;;
13) clear ; wget --load-cookies /tmp/cookies.txt ${UDPCORE} -O install-udp && rm -rf /tmp/cookies.txt && chmod +x install-udp && ./install-udp ;;
14) clear ; certv2ray ;;
15) clear ; nano /etc/issue.net ;;
16) clear ; passwd ;;
17) clear ; m-tcp ;;
18) clear ; menu-backup ;;
x) exit ;;
*) echo "Masukkan Angka Yang Benar " ; sleep 1 ; menu ;;
esac
