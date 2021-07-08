#!/bin/bash

echo "Install tools and libraries"
yum install -y gcc glibc glic-common wget unzip httpd telnet php gd gd-devel perl postfix

wget -O nagioscore.tar.gz https://github.com/NagiosEnterprises/nagioscore/archive/nagios-4.4.3.tar.gz
tar xzvf nagioscore.tar.gz
cd nagioscore-nagios-4.4.3/
./configure
make all

make install-groups-users
usermod -a -G nagios apache

make install

make install-daemoninit
systemctl enable httpd

make install-commandmode
make install-config
make install-webconf

htpasswd -c /usr/local/nagios/etc/htpasswd.users nagiosadmin

systemctl start httpd
systemctl start nagios
systemctl enable nagios
systemctl status nagios


yum install -y gcc glibc-common make gettext automake autoconf wget openssl-devel net-snmp net-snmp-utils epel-release

yum install -y perl-Net-SNMP



wget --no-check-certificate -O nagios-plugins.tar.gz https://github.com/nagios-plugins/nagios-plugins/archive/release-2.2.1.tar.gz

tar zxvf nagios-plugins.tar.gz

cd nagios-plugins-release-2.2.1/

./tools/setup
./configure
make
make install


echo "install sendmail"

wget http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

rpm -ivh epel-release-latest-7.noarch.rpm

yum update

# yum search sendemail

yum install -y sendemail

wget https://download-ib01.fedoraproject.org/pub/epel/7/x86_64/Packages/s/sendemail-1.56-1.el7.noarch.rpm

wget http://mirror.centos.org/centos/7/os/x86_64/Packages/perl-IO-Socket-INET6-2.69-5.el7.noarch.rpm

rpm -ivh perl-IO-Socket-INET6-2.69-5.el7.noarch.rpm

rpm -ivh sendemail-1.56-1.el7.noarch.rpm