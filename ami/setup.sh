#!/bin/bash

echo "Install Jenkins stable release"
yum remove -y java
yum install -y java-1.8.0-openjdk-devel wget dos2unix maven
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum install -y jenkins
chkconfig jenkins on

echo "Install git"
yum install -y git

echo "Install docker"
yum install -y docker
# sudo pip install ansible
# sudo pip install --upgrade pip

echo "Install nodejs"
sudo curl --silent --location https://rpm.nodesource.com/setup_12.x | bash -
yum -y install nodejs

echo "Setup SSH key"
mkdir /var/lib/jenkins/.ssh
touch /var/lib/jenkins/.ssh/known_hosts
chown -R jenkins:jenkins /var/lib/jenkins/.ssh
chmod 700 /var/lib/jenkins/.ssh
#mv /tmp/id_rsa /var/lib/jenkins/.ssh/id_rsa
#chmod 600 /var/lib/jenkins/.ssh/id_rsa

echo "Configure Jenkins"
mkdir -p /var/lib/jenkins/init.groovy.d

dos2unix /tmp/*
find /var/lib -type f -print0 | xargs -0 dos2unix

mv /tmp/basic-security.groovy /var/lib/jenkins/init.groovy.d/basic-security.groovy
#mv /tmp/disable-cli.groovy /var/lib/jenkins/init.groovy.d/disable-cli.groovy
#mv /tmp/csrf-protection.groovy /var/lib/jenkins/init.groovy.d/csrf-protection.groovy
#mv /tmp/disable-jnlp.groovy /var/lib/jenkins/init.groovy.d/disable-jnlp.groovy
mv /tmp/jenkins.install.UpgradeWizard.state /var/lib/jenkins/jenkins.install.UpgradeWizard.state
mv /tmp/node-agent.groovy /var/lib/jenkins/init.groovy.d/node-agent.groovy
chown -R jenkins:jenkins /var/lib/jenkins/jenkins.install.UpgradeWizard.state
mv /tmp/jenkins /etc/sysconfig/jenkins
chmod +x /tmp/install-plugins.sh
chmod +x /tmp/dockerinstall.sh
chmod +x /tmp/nagios-install.sh
chmod +x /tmp/nrpe-install.sh
chmod +x /tmp/minikube.sh
bash /tmp/dockerinstall.sh
bash /tmp/nagios-install.sh
bash /tmp/nrpe-install.sh
bash /tmp/minikube.sh
bash /tmp/install-plugins.sh
service docker start
systemctl enable docker
service jenkins start