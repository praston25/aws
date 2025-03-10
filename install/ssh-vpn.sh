#!/bin/bash
# Mod By OnePiece
# 
# ==================================================

export DEBIAN_FRONTEND=noninteractive
apt update
apt upgrade
apt-get update
apt-get upgrade -y

# Install Ssl & Certificates
apt install ssl-cert
apt install ca-certificates

# Removing some firewall tools that may affect other services
apt-get remove --purge ufw firewalld -y

# Install Speedtest
apt install python-pip
 
# Installing some important machine essentials
apt-get install nano zip unzip tar gzip p7zip-full bc rc openssl cron net-tools dnsutils dos2unix screen bzip2 ccrypt -y
 
# Now installing all our wanted services
apt-get install dropbear stunnel4 privoxy ca-certificates nginx ruby apt-transport-https lsb-release squid3 -y

# Installing all required packages to install Webmin
apt-get install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python dbus libxml-parser-perl -y
apt-get install shared-mime-info jq fail2ban -y

 
# Installing a text colorizer
gem install lolcat

# Trying to remove obsolette packages after installation
apt-get autoremove -y

GitUser="syapik96"
#wget https://github.com/${GitUser}/
# initializing var
export DEBIAN_FRONTEND=noninteractive
MYIP=$(wget -qO- ipinfo.io/ip);
MYIP2="s/xxxxxxxxx/$MYIP/g";
NET=$(ip -o $ANU -4 route show to default | awk '{print $5}');
source /etc/os-release
ver=$VERSION_ID

# certificate ssh & openvpn
# edit bwh, isikan nama domain anda
# detail nama perusahaan

country=MY
state=Malaysia
locality=Wilayah Persekutuan Kuala Lumpur
organization=OnePieceVPN Inc
organizationalunit=OnePieceVPN Officials
commonname=$(cat /root/mail1.txt)
email=$(cat /root/mail3.txt)

# simple password minimal
wget -O /etc/pam.d/common-password "https://raw.githubusercontent.com/${GitUser}/aws/main/password"
chmod +x /etc/pam.d/common-password

# go to root
cd

# Edit file /etc/systemd/system/rc-local.service
cat > /etc/systemd/system/rc-local.service <<-END
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
[Install]
WantedBy=multi-user.target
END

# nano /etc/rc.local
cat > /etc/rc.local <<-END
#!/bin/sh -e
 rc.local
# By default this script does nothing.
exit 0
END

# Ubah izin akses
chmod +x /etc/rc.local

# enable rc local
systemctl enable rc-local
systemctl start rc-local.service

# disable ipv6
echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
sed -i '$ i\echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6' /etc/rc.local

# set repo
sudo apt-get install apt-transport-https gnupg2 curl
sudo echo "deb https://download.webmin.com/download/repository sarge contrib" \ > /etc/apt/sources.list.d/webmin.list
apt install gnupg gnupg1 gnupg2 -y
curl https://download.webmin.com/jcameron-key.asc 
apt-key add jcameron-key.asc
apt-get install webmin

# Configuring webmin server config to use only http instead of https
sed -i 's|ssl=1|ssl=0|g' /etc/webmin/miniserv.conf

# Then restart to take effect
systemctl restart webmin

# set time GMT +8 # change your location #
ln -fs /usr/share/zoneinfo/Asia/Singapore /etc/localtime

# install
apt-get --reinstall --fix-missing install -y bzip2 gzip coreutils wget screen rsyslog iftop htop net-tools zip unzip wget net-tools curl nano sed screen gnupg gnupg1 bc apt-transport-https build-essential dirmngr libxml-parser-perl neofetch git
echo "clear" >> .profile
echo "neofetch" >> .profile
echo "echo AustoScriptVPN by PrinceNewbie" >> .profile
echo "echo For Enter Panel TYPE : menu" >> .profile
echo "echo Thanks For Using MyScript" >> .profile
echo "echo [*] COPYRIGHT © 2021 [*]" >> .profile

GitUser="syapik96"
#wget https://github.com/${GitUser}/

# install webserver
apt -y install nginx
cd
rm /etc/nginx/sites-enabled/default
rm /etc/nginx/sites-available/default
wget -O /etc/nginx/nginx.conf "https://raw.githubusercontent.com/${GitUser}/aws/main/nginx.conf"
mkdir -p /home/vps/public_html
echo "<h1><center> AutoScriptVPS By t.me/PrinceNewbie </center></h1>" > /home/vps/public_html/index.html
wget -O /etc/nginx/conf.d/vps.conf "https://raw.githubusercontent.com/${GitUser}/aws/main/vps.conf"
/etc/init.d/nginx restart

# install badvpn
cd /usr/bin/
wget -O badvpn-udpgw "https://github.com/${GitUser}/aws/raw/main/badvpn-udpgw64"
chmod +x badvpn-udpgw
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7400 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7500 --max-clients 500' /etc/rc.local
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7400 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7500 --max-clients 500

# setting port ssh
# Removing some duplicated sshd server configs
rm -f /etc/ssh/sshd_config*
 
# Creating a SSH server config using cat eof tricks
cat <<'MySSHConfig' > /etc/ssh/sshd_config
# My OpenSSH Server config
Port 22
Port 226
Port 40000
AddressFamily inet
ListenAddress 0.0.0.0
HostKey /etc/ssh/ssh_host_rsa_key
HostKey /etc/ssh/ssh_host_ecdsa_key
HostKey /etc/ssh/ssh_host_ed25519_key
PermitRootLogin yes
MaxSessions 1024
PubkeyAuthentication yes
PasswordAuthentication yes
PermitEmptyPasswords no
ChallengeResponseAuthentication no
UsePAM yes
X11Forwarding yes
PrintMotd no
ClientAliveInterval 240
ClientAliveCountMax 2
UseDNS no
Banner /etc/issue.net
AcceptEnv LANG LC_*
Subsystem   sftp  /usr/lib/openssh/sftp-server
MySSHConfig

# set locale
sed -i 's/AcceptEnv/#AcceptEnv/g' /etc/ssh/sshd_config

sed -i '/password\s*requisite\s*pam_cracklib.s.*/d' /etc/pam.d/common-password
sed -i 's/use_authtok //g' /etc/pam.d/common-password
# Restarting openssh service
systemctl restart ssh
 
# install dropbear
apt install dropbear -y
# Removing some duplicate config file
rm -rf /etc/default/dropbear*
 
# creating dropbear config using cat eof tricks
cat <<'MyDropbear' > /etc/default/dropbear
# My Dropbear Config
NO_START=0
DROPBEAR_PORT=443
DROPBEAR_PORT=442
DROPBEAR_EXTRA_ARGS="-p 50000 -p 109 -p 110"
DROPBEAR_BANNER="/etc/banner"
DROPBEAR_RSAKEY="/etc/dropbear/dropbear_rsa_host_key"
DROPBEAR_DSSKEY="/etc/dropbear/dropbear_dss_host_key"
DROPBEAR_ECDSAKEY="/etc/dropbear/dropbear_ecdsa_host_key"
DROPBEAR_RECEIVE_WINDOW=65536
MyDropbear

sed -i '/\/bin\/false/d' /etc/shells
sed -i '/\/usr\/sbin\/nologin/d' /etc/shells
echo "/bin/false" >> /etc/shells
echo "/usr/sbin/nologin" >> /etc/shells
systemctl restart dropbear
systemctl restart ssh
# install squid
cd
apt -y install squid3

# Removing Duplicate Squid config
 rm -rf /etc/squid/squid.con*
 
wget -O /etc/squid/squid.conf "https://raw.githubusercontent.com/${GitUser}/aws/main/squid3.conf"
sed -i "s|IP-ADDRESS|$MYIP|g" /etc/squid/squid.conf

# setting vnstat
apt -y install vnstat
/etc/init.d/vnstat restart
apt -y install libsqlite3-dev
wget https://humdi.net/vnstat/vnstat-2.6.tar.gz
tar zxvf vnstat-2.6.tar.gz
cd vnstat-2.6
./configure --prefix=/usr --sysconfdir=/etc && make && make install 
cd
vnstat -u -i $NET
sed -i 's/Interface "'""eth0""'"/Interface "'""$NET""'"/g' /etc/vnstat.conf
chown vnstat:vnstat /var/lib/vnstat -R
systemctl enable vnstat
/etc/init.d/vnstat restart
rm -f /root/vnstat-2.6.tar.gz 
rm -rf /root/vnstat-2.6

# install stunnel
apt -y install stunnel4
cat > /etc/stunnel/stunnel.conf <<-END
cert = /etc/stunnel/stunnel.pem
client = no
socket = a:SO_REUSEADDR=1
socket = l:TCP_NODELAY=1
socket = r:TCP_NODELAY=1

[dropbear]
accept = 443
connect = 127.0.0.1:109

[dropbear2]
accept = 777
connect = 127.0.0.1:22

[websocketpython]
accept = 2021
connect = 127.0.0.1:109

[websocket1]
accept = 5052
connect = 127.0.0.1:143

[openvpn]
accept = 992
connect = 127.0.0.1:1194

[openvpn2]
accept = 442
connect = 127.0.0.1:1194

END

# make a certificate
openssl genrsa -out key.pem 2048
openssl req -new -x509 -key key.pem -out cert.pem -days 1095 \
-subj "/C=$country/ST=$state/L=$locality/O=$organization/OU=$organizationalunit/CN=$commonname/emailAddress=$email"
cat key.pem cert.pem >> /etc/stunnel/stunnel.pem

# konfigurasi stunnel
sed -i 's/ENABLED=0/ENABLED=1/g' /etc/default/stunnel4
/etc/init.d/stunnel4 restart

GitUser="syapik96"
#OpenVPN
wget https://raw.githubusercontent.com/${GitUser}/aws/main/install/vpn.sh &&  chmod +x vpn.sh && ./vpn.sh

# install fail2ban
apt -y install fail2ban

# Instal DDOS Flate
if [ -d '/usr/local/ddos' ]; then
	echo; echo; echo "Please un-install the previous version first"
	exit 0
else
	mkdir /usr/local/ddos
fi
clear
echo; echo 'Installing DOS-Deflate 0.6'; echo
echo; echo -n 'Downloading source files...'
wget -q -O /usr/local/ddos/ddos.conf http://www.inetbase.com/scripts/ddos/ddos.conf
echo -n '.'
wget -q -O /usr/local/ddos/LICENSE http://www.inetbase.com/scripts/ddos/LICENSE
echo -n '.'
wget -q -O /usr/local/ddos/ignore.ip.list http://www.inetbase.com/scripts/ddos/ignore.ip.list
echo -n '.'
wget -q -O /usr/local/ddos/ddos.sh http://www.inetbase.com/scripts/ddos/ddos.sh
chmod 0755 /usr/local/ddos/ddos.sh
cp -s /usr/local/ddos/ddos.sh /usr/local/sbin/ddos
echo '...done'
echo; echo -n 'Creating cron to run script every minute.....(Default setting)'
/usr/local/ddos/ddos.sh --cron > /dev/null 2>&1
echo '.....done'
echo; 
echo 'Installation has completed.'
echo 'Config file is at /usr/local/ddos/ddos.conf'
echo 'Please send in your comments and/or suggestions to zaf@vsnl.com'

# xml parser
cd
apt install -y libxml-parser-perl

GitUser="syapik96"
# banner /etc/issue.net
wget -O /etc/issue.net "https://raw.githubusercontent.com/${GitUser}/aws/main/bannerssh.conf"
echo "Banner /etc/issue.net" >>/etc/ssh/sshd_config
sed -i 's@DROPBEAR_BANNER=""@DROPBEAR_BANNER="/etc/issue.net"@g' /etc/default/dropbear

echo -e "Install bbr dan optimasi kernel"
wget https://raw.githubusercontent.com/${GitUser}/aws/main/bbr.sh && chmod +x bbr.sh && ./bbr.sh
wget https://raw.githubusercontent.com/${GitUser}/aws/main/set-br.sh && chmod +x set-br.sh && ./set-br.sh

# block torrent
iptables -A FORWARD -m string --string "get_peers" --algo bm -j DROP
iptables -A FORWARD -m string --string "announce_peer" --algo bm -j DROP
iptables -A FORWARD -m string --string "find_node" --algo bm -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "BitTorrent protocol" -j DROP
iptables -A FORWARD -m string --algo bm --string "peer_id=" -j DROP
iptables -A FORWARD -m string --algo bm --string ".torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce.php?passkey=" -j DROP
iptables -A FORWARD -m string --algo bm --string "torrent" -j DROP
iptables -A FORWARD -m string --algo bm --string "announce" -j DROP
iptables -A FORWARD -m string --algo bm --string "info_hash" -j DROP
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save
netfilter-persistent reload

GitUser="syapik96"
# download script
cd /usr/local/sbin
wget -O add-host "https://raw.githubusercontent.com/${GitUser}/aws/main/add-host.sh"
wget -O addhost "https://raw.githubusercontent.com/${GitUser}/aws/main/tambah/addhost.sh"
wget -O about "https://raw.githubusercontent.com/${GitUser}/aws/main/about.sh"
wget -O usernew "https://raw.githubusercontent.com/${GitUser}/aws/main/usernew.sh"
wget -O trial "https://raw.githubusercontent.com/${GitUser}/aws/main/trial.sh"
wget -O hapus "https://raw.githubusercontent.com/${GitUser}/aws/main/hapus/hapus.sh"
wget -O member "https://raw.githubusercontent.com/${GitUser}/aws/main/member.sh"
wget -o webmin "https://raw.githubusercontent.com/${GitUser}/aws/main/webmin.sh"
wget -O delete "https://raw.githubusercontent.com/${GitUser}/aws/main/hapus/delete.sh"
wget -O cek "https://raw.githubusercontent.com/${GitUser}/aws/main/cek.sh"
wget -O restart "https://raw.githubusercontent.com/${GitUser}/aws/main/restart.sh"
wget -O speedtest "https://github.com/${GitUser}/aws/raw/main/speedtest_cli.py"
chmod +x speedtest
wget -O info "https://raw.githubusercontent.com/${GitUser}/aws/main/info.sh"
wget -O ram "https://raw.githubusercontent.com/${GitUser}/aws/main/ram.sh"
wget -O renew "https://raw.githubusercontent.com/${GitUser}/aws/main/renew.sh"
wget -O autokick "https://raw.githubusercontent.com/${GitUser}/aws/main/autokick.sh"
wget -O ceklim "https://raw.githubusercontent.com/${GitUser}/aws/main/ceklim.sh"
wget -O tendang "https://raw.githubusercontent.com/${GitUser}/aws/main/tendang.sh"
wget -O clear-log "https://raw.githubusercontent.com/${GitUser}/aws/main/clear-log.sh"
#wget -O update "https://raw.githubusercontent.com/${GitUser}/aws/main/update.sh"
#menu-Updated
wget -O l2tp "https://raw.githubusercontent.com/${GitUser}/aws/main/menu-update/l2tp.sh"
wget -O sssh "https://raw.githubusercontent.com/${GitUser}/aws/main/menu-update/ssh.sh"
wget -O ssssr "https://raw.githubusercontent.com/${GitUser}/aws/main/menu-update/ssssr.sh"
wget -O wgr "https://raw.githubusercontent.com/${GitUser}/aws/main/menu-update/wgr.sh"
wget -O cfd "https://raw.githubusercontent.com/${GitUser}/aws/main/panel-domain/cfd.sh"
wget -O cff "https://raw.githubusercontent.com/${GitUser}/aws/main/panel-domain/cff.sh"
wget -O cfh "https://raw.githubusercontent.com/${GitUser}/aws/main/panel-domain/cfh.sh"
wget -O add-dns "https://raw.githubusercontent.com/${GitUser}/aws/main/panel-domain/add-dns.sh"
wget -O system "https://raw.githubusercontent.com/${GitUser}/aws/main/menu-update/system.sh"
wget -O menu "https://raw.githubusercontent.com/syapik96/aws/main/menu-update/menu.sh"
chmod +x add-host
chmod +x usernew
chmod +x trial
chmod +x hapus
chmod +x member
chmod +x delete
chmod +x webmin
chmod +x cek
chmod +x restart
chmod +x info
chmod +x about
chmod +x autokick
chmod +x tendang
chmod +x ceklim
chmod +x ram
chmod +x renew
chmod +x clear-log
chmod +x l2tp
chmod +x sssh
chmod +x ssssr
chmod +x wgr
chmod +x cfd
chmod +x cff
chmod +x cfh
chmod +x system
chmod +x menu
chmod +x add-dns
echo "0 5 * * * root clear-log" >> /etc/crontab
echo "0 0 * * * root xp" >> /etc/crontab
# remove unnecessary files
apt-get -y autoclean
apt-get -y remove --purge unscd
apt-get -y --purge remove samba*;
apt-get -y --purge remove apache2*;
apt-get -y --purge remove bind9*;
apt-get -y remove sendmail*
apt-get -y autoremove

# finishing
cd
chown -R www-data:www-data /home/vps/public_html
/etc/init.d/nginx restart
/etc/init.d/openvpn restart
/etc/init.d/cron restart
/etc/init.d/ssh restart
/etc/init.d/dropbear restart
/etc/init.d/fail2ban restart
/etc/init.d/webmin restart
/etc/init.d/stunnel4 restart
/etc/init.d/vnstat restart
/etc/init.d/squid restart
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7100 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7200 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7300 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7400 --max-clients 500
screen -dmS badvpn badvpn-udpgw --listen-addr 127.0.0.1:7500 --max-clients 500

history -c
echo "unset HISTFILE" >> /etc/profile

cd
rm -f /root/ssh-vpn.sh
#rm -f /root/cert.pem
#rm -f /root/key.pem

echo '#!/bin/bash' > /usr/local/bin/reboot_otomatis 
echo 'tanggal=$(date +"%m-%d-%Y")' >> /usr/local/bin/reboot_otomatis 
echo 'waktu=$(date +"%T")' >> /usr/local/bin/reboot_otomatis
echo 'clear-log' >> /usr/local/bin/reboot-otomatis
echo 'resett' >> /usr/local/bin/reboot-otomatis
echo 'echo "Server Berhasil Reboot Pada Tanggal $tanggal Dan Jam $waktu." >> /root/log-reboot.txt' >> /usr/local/bin/reboot_otomatis 
echo '/sbin/shutdown -r now' >> /usr/local/bin/reboot_otomatis 
chmod +x /usr/local/bin/reboot_otomatis
echo "0 */12 * * * root /usr/local/bin/reboot_otomatis" > /etc/cron.d/reboot_otomatis

echo -e "Done Install SSH Services" | lolcat
figlet -f slant "AutoScript By PrinceNewbie" | lolcat
# finihsing
clear

