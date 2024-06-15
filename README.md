Checar hashs:
sha256sum nome_do_arquivo
0b6170ba88349899b7dea837c2840fb086d85e9a7b3ca8777570ccc0ddec2620 apagaregras.sh
913c454a985ae8cabe3b43c098ba5acc31e401d421ba6bb338517a56988b3919 block_input.sh
0e6ad0464bb54524a2212218d58674934102014a63dba69b29cd30daa084e50c scan2_relatorio_teste_firewall
255839789c603ba2d31a3a622b4d3e66445560d41f8c6b9069f379358d74c4f6 scan2.sh

Como executar os programas:
sudo chmod +x block_input.sh;

./block_input.sh;

Fazer o mesmo com os outros.
Abaixo, roteiro do vídeo com as explicações do código iptables e outros: 
https://www.youtube.com/watch?v=D0iZb3U5M6s&t=4s 

##########################################################################################################################
Configurar IPTABLES linux firewall anti-scan, tática MAC SPOOFING para ser anônimo, Curso segurança, [só conexão de saída)
##########################################################################################################################
iptables curso,
configurar iptables,
segurança linux,

Link github:
https://github.com/leandroibov/iptables_kernel_basico/

Autor: Leandro Santos
https:www.traderprofissional.com.br

###############################
Barreira contra scanning do ISP
###############################
Nunca se conecte ao modem diretamente ou ao roteador do seu ISP diretamente.
Conecte o modem a um pc linux ou roteador, e destes crie sua rede.
Esse pc ou roteador, voce controla. PC com Linux é melhor ainda!
Bloqueie o scanning do ISP contra sua rede com [sudo iptables -A INPUT -i ppp0 -p udp --dport 0:30000 -j DROP;]

##############################################
Conceitos básicos de rede para nmap e iptables
##############################################
echo "Tipos de rede e ips privados"
echo "10.0.0.0/8"
echo "172.16.0.0/12"
echo "192.168.0.0/16" ou 192.168.0.0/255.255.0.0
192.168.0.0/24 ou 192.168.0.0/255.255.255.0
echo "192.168.0.0/16 172.16.0.0/12 10.0.0.0/8"
echo "One specific ip target. Example 192.168.0.107"
echo "One specific network type different. Example 192.168.0.0/24 or 192.168.0.0/16"
echo "#################################################################################"
echo ""

-Calcular redes com ips e máscara de rede.
https://subnet.ninja
Número de ips da rede pela máscara de rede:
https://subnet.ninja/subnet-cheat-sheet/

- 10.0.0.0/8: Este bloco de endereços IP varia de 10.0.0.0 a 10.255.255.255. É uma rede privada de Classe A, que fornece um grande número de endereços IP disponíveis para uso em redes locais.

- 172.16.0.0/12: Este bloco de endereços IP varia de 172.16.0.0 a 172.31.255.255. É uma rede privada de Classe B, que é dividida em 16 sub-redes de Classe C.

- 192.168.0.0/16: Este bloco de endereços IP varia de 192.168.0.0 a 192.168.255.255. É uma rede privada de Classe C, que oferece um grande número de endereços IP para redes locais.

- 192.168.0.0/16 172.16.0.0/12 10.0.0.0/8: Esta é uma lista combinada dos três blocos de endereços IP mencionados acima, o que significa que inclui todas as redes privadas. Essa notação é comumente usada em configurações de firewall ou roteamento para permitir o tráfego entre todas as redes privadas.

###################
Tabelas do iptables
###################
Filter: Determinam a aceitação (ou não) de um pacote ou conexão de Entrada. (vamos usar)
Nat: encaminhamento ou compartilhamento de conexões e outros. (não vamos usar)
Mangle: Determinam a aceitação (ou não) de um pacote. (não vamos usar)
Raw: (não vamos usar)

#####################
Estratégia de defesa
#####################
- Impedir conexões de entrada ou scanning dentro da rede.
- Nenhum pc dentro da rede poderá scanear os servicos.
- Nunca usar wifi ou bluetooth.
- Usar nmap e script com todos os testes automatizados!

#### início SCRIPT block_input.sh ###
#IPTABLES CONFIGURAÇÃO PRINCIPAL - 

#Desabilitando o tráfego entre as placas - impede compartilhamento de conexão do pc para placa rj45 externa ou wifi de ponto de acesso.
#Precisa criar uma opção de script com sudo echo 1 > /proc/sys/net/ipv4/ip_forward; para permiter placa externa e ponto #de acesso funcionar.
sudo echo 0 > /proc/sys/net/ipv4/ip_forward;

#Proteção contra ping, SYN Cookies (ddos), IP Spooﬁng e proteções do kernel
sudo echo 1 > /proc/sys/net/ipv4/tcp_syncookies;

# Syn Flood (DoS) # Port scanners
sudo echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_broadcasts; 

#Redirecionamento seguro de pacotes
sudo echo 1 > $i/secure_redirects; 

# Broadcast echo protection enabled.
sudo echo 0 > /proc/sys/net/ipv4/conf/all/forwarding;

# Log strange packets.
sudo echo 1 >/proc/sys/net/ipv4/conf/all/log_martians;

# Bad error message protection enabled..
sudo echo 1 > /proc/sys/net/ipv4/icmp_ignore_bogus_error_responses; 

# IP spoofing protection.
sudo echo 1 > /proc/sys/net/ipv4/conf/all/rp_filter;

# Disable ICMP redirect acceptance.
sudo echo 0 > /proc/sys/net/ipv4/conf/all/accept_redirects;
sudo echo 0 > /proc/sys/net/ipv4/conf/all/send_redirects;

# Disable source routed packets.
sudo echo 0 > /proc/sys/net/ipv4/conf/all/accept_source_route;

#Sem tracert e ping
sudo echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_all;

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


# Definindo políticas padrões
######################
sudo iptables -P INPUT DROP  # iptables a política padrão da chain INPUT é proibir tudo
sudo iptables -P FORWARD DROP
sudo iptables -P OUTPUT ACCEPT

# Liberando a Loopback
####################
sudo iptables -A INPUT -i lo -j ACCEPT
#Esta regra permite explicitamente todo o tráfego que chega à interface de loopback (lo) para o processo local #(INPUT). Isso é importante, pois muitos serviços e aplicativos locais dependem da comunicação através da #interface de loopback para funcionar corretamente. Portanto, esta regra aceita todos os pacotes que chegam #através da interface de loopback.

sudo iptables -A FORWARD -i lo -j DROP
#Esta regra descarta todos os pacotes que chegam à interface de loopback (lo) e que estão destinados a serem #encaminhados para outras interfaces (FORWARD). Normalmente, o tráfego destinado à interface de loopback não deve #ser encaminhado para outras interfaces, pois é destinado ao próprio sistema local. Portanto, esta regra descarta #esses pacotes, como uma medida de segurança adicional para garantir que nenhum pacote da interface de loopback #seja encaminhado para fora do sistema.

## Regras de segurança na internet e acessos
#####################################
sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
#Esta regra permite que pacotes que pertençam aos estados "ESTABLISHED" e "RELATED" passem pelo filtro de entrada (INPUT).
#Pacotes no estado "ESTABLISHED" são parte de uma conexão de rede já estabelecida. Por exemplo, se você estiver navegando na web, os pacotes de dados que retornam do servidor da web para o seu computador seriam considerados ESTABLISHED
#Pacotes no estado "RELATED" estão relacionados a uma conexão de rede já estabelecida, mas não são parte direta #dela. Por exemplo, pacotes relacionados a uma conexão de FTP, como os pacotes de dados de transferência de #arquivos, podem ser considerados "RELATED".
    
sudo iptables -A FORWARD -m state --state ESTABLISHED,RELATED -j DROP
#Esta ação pode ser vista como uma medida de segurança, pois evita que pacotes de tráfego associados a conexões #estabelecidas em outros sistemas passem pelo sistema em questão. Isso pode ajudar a evitar que o sistema seja #usado como um ponto intermediário em ataques ou outras atividades maliciosas.

#Bloqueando novas conexões e conexões invalidas após ter a conexão estabelecida e relatada
sudo iptables -A INPUT -m state --state INVALID -j DROP
sudo iptables -A FORWARD -m state --state INVALID -j DROP
sudo iptables -A INPUT -m state --state NEW -j DROP
#Esta regra é um pouco diferente. Ela é aplicada aos pacotes de entrada (INPUT) que estão no estado "NEW", ou #seja, são pacotes que estão tentando estabelecer uma nova conexão. Ao encontrar esses pacotes, a ação "-j DROP" é #executada novamente, bloqueando a tentativa de estabelecer novas conexões.

#SOMENTE PCS DENTRO DA REDE PODEM SE CONECTAR
sudo iptables -A INPUT -p tcp --syn -s 192.168.0.0/255.255.255.0 -j ACCEPT; 
sudo iptables -A INPUT -p tcp --syn -j DROP;
sudo iptables -A INPUT -i ppp0 -p udp --dport 0:30000 -j DROP;
#A interface de rede "ppp0" refere-se a uma conexão de rede Point-to-Point Protocol (PPP). O PPP é um protocolo #comum usado para estabelecer uma conexão direta entre dois nós em uma rede. Ele é frequentemente usado para #conectar um computador a uma rede de Internet através de um modem discado ou de banda larga, como DSL ou cabo.

sudo echo "";

#REATIVA NETWORK REDE
sudo echo "REATIVA NETWORK REDE";
sudo echo "";
sudo service network-manager stop; 
sudo service network-manager start; 
sudo service network-manager restart; 
sudo systemctl stop NetworkManager;
sudo systemctl disable NetworkManager;
sudo systemctl enable NetworkManager;
sudo systemctl start NetworkManager;
sudo systemctl restart NetworkManager;
sudo nmcli networking off;
sudo nmcli networking on;

#LISTA REGRAS FIREWALL
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
sudo echo "############################ FIM LISTAR REGRAS IPTABLES ############################";
sudo echo "";

#### fim SCRIPT block_input.sh ###

#############################################
Mac Spoofing com Macchanger
#############################################
sudo apt install macchanger;

sudo macchanger -A interface_de_rede;


#############################################
Teste com nmap, todos as técnicas de scanning
#############################################
192.168.0.145
192.168.0.148
script scan2.sh
#instale o nmap primeiro
sudo apt update -y;
sudo apt install nmap -y;

#checar ip da rede para scanear tudo ou ip do alvo

nmcli;

./scan2.sh;

número do ip do alvo;

Testes e resultados:
sudo telnet ip_do_alvo;
sudo ssh ip_do_alvo;

Resultado do teste:
root@debian:/home/leking/Downloads# 
sudo telnet 192.168.0.132;
Trying 192.168.0.132...
telnet: Unable to connect to remote host: Connection timed out
root@debian:/home/leking/Downloads# 
sudo ssh 192.168.0.132;

ssh: connect to host 192.168.0.132 port 22: Connection timed out


