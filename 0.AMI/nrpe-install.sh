#!/bin/bash

echo "install nrpe"

wget http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm	
rpm -ivh epel-release-latest-7.noarch.rpm	
	
# yum search nrpe
yum install -y nrpe	
	
# yum search nagios | grep -i plugin	
	
yum install -y nagios-plugins-all
	
# systemctl status nrpe	
	
systemctl start nrpe	
	
systemctl enable nrpe	
	
yum install -y nagios-plugins-nrpe	
	
# cd /usr/lib64/nagios/plugins/

# https://sourceforge.net/projects/nscplus/  (Access the URL on the browser to download nsclient (nagios agent) for windows server. Click on download the NSCP-0.4.1.73-x64.msi)