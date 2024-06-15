echo "Apagando regras do iptables sudo iptables -F, -X e -Z para todas as tabelas"
sudo iptables -F  # Remove as regras de todas as chains
sudo iptables -X  # Apaga todas as chains
sudo iptables -Z  # Zera as regras de todas as chains

sudo iptables -P INPUT ACCEPT;
sudo iptables -P FORWARD ACCEPT;
sudo iptables -P OUTPUT ACCEPT;

sudo iptables -t filter -F;
sudo iptables -t filter -X;
sudo iptables -t filter -Z;

sudo iptables -t nat -F;
sudo iptables -t nat -X;
sudo iptables -t nat -Z;

sudo iptables -t mangle -F;
sudo iptables -t mangle -X;
sudo iptables -t mangle -Z;


sudo iptables -t raw -F;
sudo iptables -t raw -X;
sudo iptables -t raw -Z;


sudo echo "";

sudo echo "";
echo "############################ LISTA REGRAS IPTABLES ############################"
sudo echo "";
sudo echo "############################ Table Filter ############################";
sudo iptables -t filter -S;
sudo echo "";

sudo echo "############################ Table Nat ############################";
sudo iptables -t nat -S;
sudo echo "";

sudo echo "############################ Table Mangle ############################";
sudo iptables -t mangle -S;
sudo echo "";

sudo echo "############################ Table Raw ############################";
sudo iptables -t raw -S;
sudo echo "";
