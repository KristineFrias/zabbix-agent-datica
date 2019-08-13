#!/bin/bash -e

#Install and configure Zabbix Agent
#Platform Ubuntu/Debian

if [ "$UID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

if [ -x /usr/bin/apt-get ]; then
  apt-get update
  apt-get -y install zabbix-agent sysv-rc-conf
  sysv-rc-conf zabbix-agent on

  echo Updating zabbix_agentd.conf
  sed -i 's/Server=127.0.0.1/Server=127.0.0.1,34.217.30.172/' /etc/zabbix/zabbix_agentd.conf
  sed -i 's/ServerActive=127.0.0.1/ServerActive=34.217.30.172/' /etc/zabbix/zabbix_agentd.conf
  HOSTNAME=`curl -s http://169.254.169.254/latest/meta-data/local-hostname` && sed -i "s/Hostname=Zabbix\ server/Hostname=$HOSTNAME/" /etc/zabbix/zabbix_agentd.conf
  service zabbix-agent restart
fi


#!/bin/bash -e

#Install and configure Zabbix Agent
#Platform Ubuntu/Debian

HOSTNAME=`curl -s http://169.254.169.254/latest/meta-data/local-hostname`
sed -i 's/Server=127.0.0.1/Server=127.0.0.1,34.217.30.172/' /etc/zabbix/zabbix_agentd.conf
sed -i 's/ServerActive=127.0.0.1/ServerActive=34.217.30.172/' /etc/zabbix/zabbix_agentd.conf
sed -i "s/Hostname=Zabbix\ server/Hostname=$HOSTNAME/" /etc/zabbix/zabbix_agentd.conf


