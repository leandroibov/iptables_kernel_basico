
echo "_________________________________________________________________________________"
echo "EAGLE NMAP SCANNING NETWORK SCRIPT 2"
echo "All nmap scanning technics automated"
echo "Developer: [Leandro Santos]"
echo "_________________________________________________________________________________"
echo "_________________________________________________________________________________"
echo ""

echo "#################################################################################"
echo "Type of networks and options"
echo "10.0.0.0/8 "
echo "172.16.0.0/12 "
echo "192.168.0.0/16"
echo "192.168.0.0/16 172.16.0.0/12 10.0.0.0/8"
echo "One specific ip target. Example 192.168.0.107"
echo "One specific network type different. Example 192.168.0.0/24 or 192.168.0.0/16"
echo "#################################################################################"
echo ""

read -p "Enter the number of ip network you desired: " alvo

echo "_________________________________________________________________________________"
echo "_________________________________________________________________________________"
echo "NMAP Scanning Techniques"
echo "_________________________________________________________________________________"
echo "_________________________________________________________________________________"
echo ""
echo "#################################################################################"
#TCP syn port scan
echo "#TCP syn port scan -> sudo nmap -sS ip_address"
echo "#################################################################################"
sudo nmap -sS "$alvo"
echo ""
echo "#################################################################################"
#TCP connect port scan
echo "#TCP connect port scan -> sudo nmap -sT ip_address"
echo "#################################################################################"
sudo nmap -sT "$alvo" 
echo ""
echo "#################################################################################"
#UDP port scan
echo "#UDP port scan -> sudo nmap –sU ip_address"
echo "#################################################################################"
sudo nmap –sU "$alvo"  
echo ""
echo "#################################################################################"
#TCP ack port scan
echo "#TCP ack port scan -> sudo nmap –sA ip_address"
echo "#################################################################################"
sudo nmap –sA "$alvo"  
echo ""

echo "_________________________________________________________________________________"
echo "_________________________________________________________________________________"
#Host Discovery
echo "#Host Discovery"
echo "_________________________________________________________________________________"
echo "_________________________________________________________________________________"
echo ""
echo "#################################################################################"
#only port scan
echo "#Only port scan -> sudo nmap -Pn ip_address"
echo "#################################################################################"
sudo nmap -Pn "$alvo" 
echo ""
echo "#################################################################################"
#only host discover
echo "#Only host discover -> sudo nmap -sn ip_address"
echo "#################################################################################"
sudo nmap -sn "$alvo" 
echo ""
echo "#################################################################################"
#arp discovery on a local network
echo "#Arp discovery on a local network -> sudo nmap -PR ip_address"
echo "#################################################################################"
sudo nmap -PR "$alvo"
echo ""
echo "#################################################################################"
#disable DNS resolution
echo "#Disable DNS resolution -> sudo nmap -n ip_address"
echo "#################################################################################"
sudo nmap -n "$alvo"
echo "" 
echo "_________________________________________________________________________________"
echo "________________________________________________________________________________"
#Service Version and OS Detection
echo "#Service Version and OS Detection"
echo "_________________________________________________________________________________"
echo "_________________________________________________________________________________"
echo ""
echo "#################################################################################"
#detect the version of services running
echo "#Detect the version of services running -> sudo nmap -sV ip_address"
echo "#################################################################################"
sudo nmap -sV "$alvo" 
echo ""
echo "#################################################################################"
#aggressive scan
echo "#Aggressive scan -> sudo nmap -A ip_address"
echo "#################################################################################"
sudo nmap -A "$alvo" 
echo ""
echo "#################################################################################"
#detect operating system of the target
echo "#Detect operating system of the target -> sudo nmap -O ip_address"
echo "#################################################################################"
sudo nmap -O "$alvo" 
echo ""

echo "_________________________________________________________________________________"
echo "_________________________________________________________________________________"
#IDS Evasion
echo "#IDS Evasion"
echo "_________________________________________________________________________________"
echo "_________________________________________________________________________________"
echo ""
echo "#################################################################################"
#use fragmented IP packets
echo "#Use fragmented IP packets -> sudo nmap -f ip_address"
echo "#################################################################################"
sudo nmap -f "$alvo" 
echo ""





